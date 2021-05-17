#!/bin/bash

#Set SELinux & Swap#
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
setenforce 0
swapoff -a
sed -i 's/\/dev\/mapper\/centos-swap/\#\/dev\/mapper\/centos-swap/' /etc/fstab

#Set Firewall#
firewall-cmd --permanent --add-port=10252/tcp
firewall-cmd --permanent --add-port=10255/tcp
firewall-cmd --permanent --add-port=30000-32767/tcp
firewall-cmd --permanent --add-port=6783/tcp
firewall-cmd --reload
modprobe br_netfilter
echo "1" > /proc/sys/net/bridge/bridge-nf-call-iptables

#Configure Kubernetes Repository#
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
EOF

#Install Docker & Kubernetes#
yum repolist
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install kubeadm -y
yum install docker-ce -y
systemctl start docker
systemctl enable docker

#Set Cgroup#
cat <<EOF > /etc/docker/daemon.json
{
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts": {
"max-size": "100m"
},
"storage-driver": "overlay2"
}
EOF

#Restart Service#
systemctl daemon-reload
systemctl restart docker