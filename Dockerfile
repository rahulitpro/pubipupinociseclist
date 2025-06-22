from oraclelinux:9

run dnf install bind-utils -y

run dnf install oraclelinux-developer-release-el9 -y

run dnf install python39-oci-cli -y

run dnf install jq -y

run useradd -m -d /oracle oracle


copy updateociseclistwithpubip.sh /oracle/updateociseclistwithpubip.sh
run chown oracle:oracle /oracle/updateociseclistwithpubip.sh
run chmod 755 /oracle/updateociseclistwithpubip.sh


workdir /oracle
user oracle

cmd ["/oracle/updateociseclistwithpubip.sh"]

