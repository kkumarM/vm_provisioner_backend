#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

echo -e "\e[1;33mInstalling CRI-O...This might take few mins....\e[0m"
echo -e "\e[1;35mSetting up CRI-O Repository...\e[0m"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
echo -e "\e[1;36mChecking OS_VERSION...\e[0m"
OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo -e "\e[1;36mSystem OS : $OS_VERSION\e[0m"
if [[ $OS_VERSION == "18.04" ]]; then
	export OS_VERSION=xUbuntu_18.04
else
	export OS_VERSION=xUbuntu_20.04
fi
export CRIO_VERSION=1.23
curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS_VERSION/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/libcontainers-archive-keyring.gpg
curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS_VERSION/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/libcontainers-crio-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/libcontainers-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS_VERSION/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb [signed-by=/usr/share/keyrings/libcontainers-crio-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS_VERSION/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list
echo -e "\e[1;35mInstalling CRI-O components...\e[0m"
sudo apt update
sudo apt install -y cri-o cri-o-runc
echo -e "\e[1;35mStarting and enabling CRI-O Service...\e[0m"
sudo systemctl daemon-reload
sudo systemctl enable crio
sudo systemctl start crio
echo "\e[1;35mInstalling CNI Plugins For CRI-O...\e[0m"
sudo apt install -y containernetworking-plugins
sudo systemctl restart crio
echo -e "\e[1;35mVerifying CRI-O Installation...\e[0m"
sudo apt install -y cri-tools
version_info=$(sudo crictl --runtime-endpoint unix:///var/run/crio/crio.sock version)
echo -e "\e[1;32mCRIO-O is installed\e[0m"
echo -e "\e[1;32m$version_info\e[0m" 
