#!/bin/bash

#################################################################
#File:    rsaconnect                                            #
#Author:  Nicolas SALMIN                                        #
#Date:    Created: 03/12/2019                                   #
#Version: 1.0                                                   #
#Brief:   Generate and send RSA to a remote device              #
#Usage:   ./rsaconnect <user_name> <ip_addr> <ssh_port> <alias> #
#Example: ./rsaconnect pi 192.168.42.1 2222 rpp4                #
#################################################################

clear;
cat << "EOF"
   _______________
  |  ___________  |  _____   _____             _____                            _
  | |           | | |  __ \ / ____|  /\       / ____|                          | |
  | |   0   0   | | | |__) | (___   /  \     | |     ___  _ __  _ __   ___  ___| |_
  | |     -     | | |  _  / \___ \ / /\ \    | |    / _ \| '_ \| '_ \ / _ \/ __| __|
  | |   \___/   | | | | \ \ ____) / ____ \   | |___| (_) | | | | | | |  __/ (__| |_
  | |___     ___| | |_|  \_\_____/_/    \_\   \_____\___/|_| |_|_| |_|\___|\___|\__| V1.0
  |_____|\_/|_____|
    _|__|/ \|_|_. | If you frequently access a lot of different remote systems via SSH,
   / ********** \       this trick will save you some time.
 /  ************  \
--------------------
EOF

if [ $# -ne 4 ]; then
    read -p "Enter remote user name: " UNAME
    read -p "Enter remote ip address: " IPADDR
    read -p "Enter remote ssh port: " SSHPORT
    read -p "Enter remote alias: " UALIAS
else
    UNAME="$1"
    IPADDR="$2"
    SSHPORT="$3"
    UALIAS="$4"
fi

RSA_KEY="$HOME/.ssh/id_rsa_$UALIAS"
CONFIG_FILE="$HOME/.ssh/config"

echo -e "Step 1: Checking for existing SSH keys"
if [[ -f "$RSA_KEY" || -f "$RSA_KEY.pub" ]]; then
   echo "Error: Please remove $RSA_KEY and/or $RSA_KEY.pub manually."
   exit 2
fi

if  grep -q "Hostname $IPADDR" "$CONFIG_FILE" ; then
    echo "Hostname already exists in $CONFIG_FILE. Please fix."
    exit 3
fi

if  grep -q "Host $UALIAS" "$CONFIG_FILE" ; then
    echo "Alias already exists in $CONFIG_FILE. Please fix."
    exit 3
fi

echo -e -n "Step 2: Checking host availability... "
ping -w 3 -c 1 $IPADDR &> /dev/null
if [ "$?" = 0 ]
then
    echo "Host is alive"
else
    echo "Host not found. Please fix."
    exit 4
fi

echo "************************************"
echo "RSA key: $RSA_KEY"
echo "Remote name:     $UNAME"
echo "Ip address:      $IPADDR"
echo "Ssh port:        $SSHPORT"
echo "Remote alias:    $UALIAS"
echo "************************************"
echo ""

read -r -p "Are You Sure? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
    ;;
    [nN][oO]|[nN])
    exit 0
    ;;
    *)
 echo "Invalid input..."
 exit 1
 ;;
esac

echo -e "Step 3: Create .ssh directory & authorized_keys file in $HOME folder"
cd "$HOME" || exit 1
mkdir .ssh -p && cd .ssh || exit 1
touch authorized_keys

echo -e "Step 4: Set permissions"
chmod 700 "$HOME"/.ssh/
chmod 600 "$HOME"/.ssh/authorized_keys

echo -e "Step 5: Creating a new key pair"
cd "$HOME"/.ssh || exit 1
cat < /dev/zero | ssh-keygen -f $RSA_KEY -t ecdsa -b 521 -N "" > /dev/null

echo -e "Step 6: Sending RSA key to the remote machine"
cat < "$RSA_KEY.pub" | ssh -p $SSHPORT -o IdentitiesOnly=yes "$UNAME@$IPADDR" 'mkdir -p $HOME/.ssh &&  touch $HOME/.ssh/authorized_keys && cat >> $HOME/.ssh/authorized_keys'

echo -e "Step 7: Adding alias to ssh config file"
if test -f "$CONFIG_FILE"; then
    touch "$CONFIG_FILE"
else
    echo "$CONFIG_FILE already exists. Skipped."
fi

echo -e "Step 8: Adding alias to ssh config file"
{
    echo ""
    echo "Host $UALIAS"
    echo "    Hostname $IPADDR"
    echo "    Port $SSHPORT"
    echo "    User $UNAME"
    echo "    IdentitiesOnly=yes"
    echo "    IdentityFile $RSA_KEY.pub"
} >> "$CONFIG_FILE"

echo -e "Step 9: Try RSA key"
echo "We will try to connect you to your host: $UNAME@$IPADDR"
read -p "Continue? [Yy]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ssh "$UALIAS" && exit 0
fi
