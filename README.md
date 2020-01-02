### RSA Key Auto-Connect Script

> **Simple script to create SSH alias in Linux:**

If you frequently access a lot of different remote systems via SSH, this trick will save you some time. \
You can create SSH alias to frequently-accessed systems via SSH. \
This way you need not to remember all the different usernames, hostnames, IP addresses etc. \
Additionally, It avoids the need to repetitively type the same username/hostname, ip address, password to connect into a Linux remote.

## Usage
```bash
#  Passing Arguments to the Script
[nicolas:rsaconnect]% ./rsaconnect.sh <user_name> <ip_addr> <port> <alias>
# Without any arguments
[nicolas:rsaconnect]% ./rsaconnect.sh
```

## Examples

```bash
Step 1: Checking for existing SSH keys
Step 2: Checking host availability... Host is alive
************************************
RSA key: /home/nicolas/.ssh/id_rsa_rpp4
Remote name:     pi
Ip address:      10.2.161.3
Ssh port:        22
Remote alias:    rpp4
************************************

Are You Sure? [Y/n] y
Step 3: Create .ssh directory & authorized_keys file in /home/nicolas folder
Step 4: Set permissions
Step 5: Creating a new key pair
Step 6: Sending RSA key to the remote machine
pi@10.2.161.3's password:
Step 7: Adding alias to ssh config file
Step 8: Try RSA key
We will try to connect you to your host: pi@10.2.161.3
Continue? [Yy]y
[TEST] Connection successful.

```

```bash
Enter remote user name: pi
Enter remote ip address: 10.2.161.3
Enter remote ssh port: 22
Enter remote alias: rpp4
Step 1: Checking for existing SSH keys
Step 2: Checking host availability... Host is alive
************************************
RSA key: /home/nicolas/.ssh/id_rsa_rpp4
Remote name:     pi
Ip address:      10.2.161.3
Ssh port:        22
Remote alias:    rpp4
************************************

Are You Sure? [Y/n] y
Step 3: Create .ssh directory & authorized_keys file in /home/nicolas folder
Step 4: Set permissions
Step 5: Creating a new key pair
Step 6: Sending RSA key to the remote machine
pi@10.2.161.3's password:
Step 7: Adding alias to ssh config file
Step 8: Try RSA key
We will try to connect you to your host: pi@10.2.161.3
Continue? [Yy]y
[TEST] Connection successful.
```
