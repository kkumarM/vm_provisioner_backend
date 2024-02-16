#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

export HOST_IP=$(hostname -I | cut -d' ' -f1)

if [[ $(which docker) && $(docker --version) ]]; then
         echo "Docker is installed "
     else
         echo "Install docker from devtool"
         # command
         #sudo apt-get remove docker docker-engine docker.io containerd runc
fi

#install kubeadm
sudo ufw allow 30050
sudo ufw allow 30050/tcp
if [[ $(which kubeadm) && $(sudo kubeadm version) ]]; then
         echo "kubeadm is installed"
     else
         echo "installing kubeadm....."
         echo
         sudo mkdir /etc/docker
         echo "{
         \"exec-opts\": [\"native.cgroupdriver=systemd\"],
         \"log-driver\": \"json-file\",
         \"log-opts\":  {
         \"max-size\": \"100m\"
         },
         \"storage-driver\": \"overlay2\"
         }" | sudo tee /etc/docker/daemon.json
         sudo systemctl enable --now docker
         sudo systemctl daemon-reload
         sudo systemctl restart docker
         #sudo systemctl status docker
         sudo groupadd docker
         sudo usermod -aG docker $USER
         echo "Disabling swap"
         sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
         sudo swapoff -a
         echo "br_netfilter" | sudo tee /etc/modules-load.d/k8s.conf
         echo "net.bridge.bridge-nf-call-ip6tables = 1
         net.bridge.bridge-nf-call-iptables = 1" | sudo tee  /etc/sysctl.d/k8s.conf
         echo "Installing Kubectl and Kubernetes"
         sudo apt-get update -y
         sudo apt-get install -y apt-transport-https ca-certificates curl
         sudo sysctl --system
         sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
         echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
         echo "Updating apt package"
         sudo apt-get update
         sudo apt-get install -y kubeadm=1.23* kubelet=1.23* kubectl=1.23*
         sudo apt-mark hold kubelet kubeadm kubectl
         sudo kill -9 `sudo lsof -t -i:10250`
         sudo sed -i '9s/^/Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"\n/' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
         sudo systemctl daemon-reload
         sudo systemctl restart kubelet
         echo "Initializing kubeadm"
         sudo kubeadm init --ignore-preflight-errors=all --pod-network-cidr=172.31.28.0/24
         mkdir -p $HOME/.kube
         sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
         sudo chown $(id -u):$(id -g) $HOME/.kube/config
         GITHUB_URL=https://github.com/kubernetes/dashboard/releases
         VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
         kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
         kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
         kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard --type='json' -p '[{"op":"replace","path":"/spec/ports/0/nodePort","value":30050}]'
         kubectl get svc -n kubernetes-dashboard -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}'
         kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
         echo "ClusterIP replaced with NodePort"
         NODE_PORT=`kubectl get svc -n kubernetes-dashboard -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}'`
         echo -e "\e[1;36mIt will take couple of minutes for the kubeadm server to start up\e[0m"
         echo -e "\e[1;36mPlease use generated token to login into your dashboard\e[0m"
         echo -e "\e[1;33mInstalled kubeadm successfully, Control Plane can be accessed by clicking https://"$HOST_IP":"$NODE_PORT"\e[0m"
fi
