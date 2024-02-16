#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the containerd is installed 
#Installing Containerd
echo -e "\e[1;33mInstalling Conatinerd... This might take few mins...\e[0m"
wget https://github.com/containerd/containerd/releases/download/v1.6.4/containerd-1.6.4-linux-amd64.tar.gz
echo "intel123" | sudo -S tar Czxvf /usr/local containerd-1.6.4-linux-amd64.tar.gz
#Downloading the systemd service file and setting it up so that the service can be managed via systemd
wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo mv containerd.service /usr/lib/systemd/system/
#Strating the containerd service
echo -e "\e[1;35mStrating the containerd service...\e[0m"
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
#Installing runc
echo -e "\e[1;33mInstalling runc...\e[0m"
wget https://github.com/opencontainers/runc/releases/download/v1.1.1/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
#Containerd configuration for Kubernetes
echo -e "\e[1;35mContainerd configuration for Kubernetes...\e[0m"
sudo mkdir -p /etc/containerd/
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
#Restarting the containerd service
sudo systemctl restart containerd
#Installing CNI Plugins For Containerd
echo -e "\e[1;33mInstalling CNI Plugins For Containerd...\e[0m"
sudo mkdir -p /opt/cni/bin/
sudo wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
#Restarting the containerd service
sudo systemctl restart containerd
echo -e "\e[1;32mContainerd service is up and running...\e[0m"
if [[ $(containerd --version) ]]; then
	containerd_version=$(containerd --version | awk '{print $3}')
        echo -e "\e[1;32mContainerd : $containerd_version is installed\e[0m"
fi
