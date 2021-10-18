#!/bin/bash
#This is a script for create a new user in linux and their respective new ssh key for access

#user
USERNAMENEW=$1

sudo useradd -m -d /home/${USERNAMENEW} -s /bin/bash ${USERNAMENEW}
sudo mkdir -p /home/${USERNAMENEW}/.ssh/
sudo touch /home/${USERNAMENEW}/.ssh/authorized_keys
cd /home/${USERNAMENEW}/
sudo chmod 700 .ssh
sudo chmod 600  .ssh/authorized_keys
sudo chown ${USERNAMENEW}:root .ssh/authorized_keys
sudo chown ${USERNAMENEW}:root .ssh

ssh-keygen -t rsa -b 4096 -C "ssh key for user ${USERNAMENEW}" -f /home/${USERNAMENEW}/.ssh/id_rsa -N ""

HOSTT=$(hostname)
sed "s/ssh key for user ${USERNAMENEW}/${USERNAMENEW}@${HOSTT}/g" /home/${USERNAMENEW}/.ssh/id_rsa.pub  >> /home/${USERNAMENEW}/.ssh/id_rsa.pub${USERNAMENEW}
cat /home/${USERNAMENEW}/.ssh/id_rsa.pub${USERNAMENEW}  >>  /home/${USERNAMENEW}/.ssh/authorized_keys


echo "Now you can login remotly using this private key, /home/${USERNAMENEW}/.ssh/id_rsa"
