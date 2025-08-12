#!/bin/bash

export OCI_CLI_PROFILE=$OCI_CLI_PROFILE

while [ 0 ]
do

nslookup myip.opendns.com `nslookup resolver1.opendns.com 8.8.8.8 | awk -F': ' 'NR==6 { print $2 } '` | awk -F': ' 'NR==6 { print $2 } ' > /tmp/mypubip.txt
MY_PUB_IP=`cat /tmp/mypubip.txt`
echo Current Public IP address is "$MY_PUB_IP"

oci network security-list get --security-list-id  $SEC_LIST_ID > /tmp/current_sec_list.txt
CURR_PUB_IP=`jq '.data."ingress-security-rules"' /tmp/current_sec_list.txt | jq '.[] | .source' | grep '\/32' | sed 's/\/32//g' | sed 's/\"//g' | sort -u`
echo Public IP address in Security list is "$CURR_PUB_IP"

if [ "$MY_PUB_IP" == "$CURR_PUB_IP" ]
then

echo Security list has updated ip address

else

echo Creating ingress-security-rules file

jq '.data."ingress-security-rules"' /tmp/current_sec_list.txt > /tmp/ingress-security-rules.txt

sed -i "s/$CURR_PUB_IP/$MY_PUB_IP/" /tmp/ingress-security-rules.txt > /dev/null

echo updating public ip

oci network security-list update --security-list-id $SEC_LIST_ID --ingress-security-rules  file:///tmp/ingress-security-rules.txt --force
	
oci network security-list get --security-list-id  $SEC_LIST_ID > /tmp/current_sec_list.txt

CURR_PUB_IP=`jq '.data."ingress-security-rules"' /tmp/current_sec_list.txt | jq '.[] | .source' | grep '\/32' | sed 's/\/32//g' | sed 's/\"//g' | sort -u`
	
echo Public IP address in Security list is set to $CURR_PUB_IP

fi

echo sleeping for an hour 

sleep 3600 

done
