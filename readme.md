This project is to update current public ip in Oracle Cloud Security list

Prereq.
******

mkdir $HOME/.oci

You will get below template for your oci environment while creating API key copy from there


Copy  API private key file name in $HOME/.oci directory


echo "[DEFAULT]
user=ocid1.user.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
fingerprint=xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx
tenancy=ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
region=xx-xxxxxx-x
key_file=/oracle/.oci/<replace with API private key file name in $HOME/.oci directory>.pem
" > $HOME/.oci/config

chmod 600 $HOME/.oci/*

$ cd $HOME/.oci/

$ ls -tlr
total 8
-rw-------. 1 rahul rahul 1715 Jun 21 08:13 <API private key file>.pem
-rw-------. 1 rahul rahul  308 Jun 21 10:40 config

Install Docker


How to Build
************

cd pubipupinociseclist

docker build -t pubipupinociseclist .

How to run
***********

docker run --name <container_name> --dns=8.8.8.8 -e SEC_LIST_ID=<your_oci_secury_list_id> -e OCI_CLI_PROFILE=<your_oci_cloud_profile_in_config_file> -v "$HOME/.oci:/oracle/.oci"  --restart unless-stopped -d pubipupinociseclist
