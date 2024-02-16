#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

sudo apt-get update -y

sudo apt-get install curl
echo -e "\e[1;32mInstalling curl.... \e[0m"
sudo apt-get install apt-transport-https

#installing docker 
if [[ $(which docker) && $(docker --version) ]]; then
         echo -e "\e[1;36mDockerce is present in the system\e[0m"
     else
         echo -e "\e[1;36mInstall docker from devtool\e[0m"
fi
# Adding docker group 
#sudo usermod -aG docker $USER && newgrp docker
#installing minikube
sudo ufw allow 8001
sudo ufw allow 8001/tcp
if [[ $(which minikube) && $(minikube version) ]]; then
	 echo "minikube is present in the system"
     else
	 echo -e "\e[1;32mInstalling minikube..... \e[0m" 
	 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
         sudo install minikube-linux-amd64 /usr/local/bin/minikube
	 echo -e "\e[1;32mInstalling kubectl..... \e[0m"
	 curl -LO https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl
	 sudo chmod +x ./kubectl
	 sudo mv ./kubectl /usr/local/bin/kubectl
	 echo -e "\e[1;32mInstallation of minikube and kubectl completed\e[0m"
fi


