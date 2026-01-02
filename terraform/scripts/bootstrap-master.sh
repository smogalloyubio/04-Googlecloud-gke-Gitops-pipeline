#!/bin/bash
set -euo pipefail

# Basic kubeadm master bootstrap for Ubuntu 22.04
# Run as root (sudo)

# Disable swap
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab || true

# Install prerequisites
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Install containerd
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y containerd.io
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
systemctl enable --now containerd

# Install kubeadm, kubelet, kubectl
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
systemctl enable --now kubelet

# Prepare sysctl
cat <<EOF >/etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# Initialize cluster (adjust pod-network-cidr if you prefer another CNI)
KUBEADM_INIT_ARGS="--pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=$(hostname -I | awk '{print $1}')"

kubeadm init $KUBEADM_INIT_ARGS --ignore-preflight-errors=Swap

# Configure kubectl for root
export KUBECONFIG=/etc/kubernetes/admin.conf

# Install Calico CNI
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Create a join command and save to file for workers
kubeadm token create --print-join-command > /root/join_command.sh
chmod +x /root/join_command.sh

echo "Join command saved to /root/join_command.sh"

echo "Master setup complete. Use the join command on each worker (run as root): /root/join_command.sh"
