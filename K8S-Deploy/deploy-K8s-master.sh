#!/bin/bash

#Set SElinux & Swap#
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
setenforce 0
swapoff -a
sed -i 's/\/dev\/mapper\/centos-swap/\#\/dev\/mapper\/centos-swap/' /etc/fstab

#Set Firewall#
firewall-cmd --permanent --add-port=6443/tcp
firewall-cmd --permanent --add-port=2379-2380/tcp
firewall-cmd --permanent --add-port=10250/tcp
firewall-cmd --permanent --add-port=10251/tcp
firewall-cmd --permanent --add-port=10252/tcp
firewall-cmd --permanent --add-port=10255/tcp
firewall-cmd --permanent --add-port=30000-32767/tcp
firewall-cmd --add-masquerade --permanent
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
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install kubeadm -y
yum install kubectl -y
yum install kubelet -y
yum install docker-ce -y
yum install epel-release -y
yum repolist
systemctl start docker
systemctl enable docker
systemctl start kubelet
systemctl enable kubelet

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
systemctl restart kubelet

#Initialize Kubernetes Master#
kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

#Set Network Management#
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

#Set Sysctl#
cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

#Install Helm & Tiller#
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > /tmp/install-helm.sh
chmod u+x /tmp/install-helm.sh
sh /tmp/install-helm.sh
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller