#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.16.101 kmaster1.example.com kmaster1
172.16.16.102 kmaster2.example.com kmaster2
172.16.16.103 kmaster3.example.com kmaster3
172.16.16.201 kworker1.example.com kworker1
172.16.16.202 kworker2.example.com kworker2
EOF


# Enable ssh password authentication
echo "[TASK 11] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc

