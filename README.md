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
[nicolas:rsaconnect]% ./rsaconnect.sh pi 10.2.161.16 rpp4
Step 1: Checking for existing SSH keys
Step 2: Checking host availability... Host is alive
************************************
RSA key: /home/nicolas/.ssh/id_rsa_rpp4
Remote name:     pi
Ip address:      10.2.161.16
Remote alias:    rpp4
************************************

Are You Sure? [Y/n] y
Step 3: Create SSH Directory & authorized_keys File
Step 4: Set Permissions
Step 5: Creating a New Key Pair
Step 6: Sending RSA key to the remote machine
pi@10.2.161.16's password:
Step 7: Adding alias to ssh config file
Step 8: Adding alias to ssh config file
Step 9: Try RSA key
We will try to connect you to your host: pi@10.2.161.16
Continue? [Yy]y
Linux raspberrypi 4.19.75-v7l+ #1270 SMP Tue Sep 24 18:51:41 BST 2019 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Tue Dec  3 10:15:14 2019 from 10.2.161.70

SSH is enabled and the default password for the 'pi' user has not been changed.
This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.

pi@raspberrypi:~ $
```

```bash
[nicolas:rsaconnect]% ./rsaconnect.sh
Enter remote user name: pi
Enter remote ip address: 10.2.161.16
Enter remote alais: rpp4
Step 1: Checking for existing SSH keys
Step 2: Checking host availability... Host is alive
************************************
RSA key: /home/nicolas/.ssh/id_rsa_rpp4
Remote name:     pi
Ip address:      10.2.161.16
Remote alias:    rpp4
************************************

Are You Sure? [Y/n] y
Step 3: Create SSH Directory & authorized_keys File
Step 4: Set Permissions
Step 5: Creating a New Key Pair
Step 6: Sending RSA key to the remote machine
pi@10.2.161.16's password:
Step 7: Adding alias to ssh config file
Step 8: Adding alias to ssh config file
Step 9: Try RSA key
We will try to connect you to your host: pi@10.2.161.16
Continue? [Yy]y

Linux raspberrypi 4.19.75-v7l+ #1270 SMP Tue Sep 24 18:51:41 BST 2019 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Tue Dec  3 10:13:56 2019 from 10.2.161.70


SSH is enabled and the default password for the 'pi' user has not been changed.
This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.

pi@raspberrypi:~ $
```
