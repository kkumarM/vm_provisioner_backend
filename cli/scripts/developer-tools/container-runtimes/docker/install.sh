#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the docker is already installed in the system
if [[ $(which docker) && $(docker --version) ]]; then
   docker_version=$(docker --version | awk {'print $3'})
   echo -e "\e[1;32mDocker : $docker_version is already installed in the system\e[0m"
else
   #Installing docker
   echo -e "\e[1;33mInstalling docker... This might take few mins...\e[0m"
   echo "intel123" | sudo -S apt-get update
   sudo apt-get install -y ca-certificates curl gnupg lsb-release
   sudo mkdir -p /etc/apt/keyrings
   if [[ -f /etc/apt/keyrings/docker.gpg ]]; then
           sudo rm /etc/apt/keyrings/docker.gpg
   fi
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
   #Checking if the docker is installed
   if [[ $(which docker) && $(docker --version) ]]; then
           docker_version=$(docker --version | awk {'print $3'})
           echo -e "\e[1;32mDocker : $docker_version is installed\e[0m"
   fi
fi
#configuring the proxy
if [[ (-f /etc/systemd/system/docker.service.d/proxy.conf) || ((-f /etc/systemd/system/docker.service.d/http-proxy.conf) && (-f /etc/systemd/system/docker.service.d/https-proxy.conf)) ]]; then
   echo -e "\e[1;32mProxy already configured in the system\e[0m"
   echo -e "\e[1;32mGetting Started Guide : https://docs.docker.com/get-started/\e[0m"
else
   echo -e "\e[1;33mConfiguring the proxy\e[0m"
   export DKR_PROXY='"HTTP_PROXY=http://proxy-chain.intel.com:911/" "HTTPS_PROXY=http://proxy-chain.intel.com:911/" "NO_PROXY=127.0.0.1,127.0.1.1,localhost,.intel.com"'
   sudo mkdir -p /etc/systemd/system/docker.service.d
   sudo chmod 755 /etc/systemd/system/docker.service.d
   sudo touch /etc/systemd/system/docker.service.d/proxy.conf
   sudo chmod 777 /etc/systemd/system/docker.service.d/proxy.conf
   echo -e "[Service]\nEnvironment=$DKR_PROXY" > /etc/systemd/system/docker.service.d/proxy.conf
   if [[ (-f /etc/systemd/system/docker.service.d/proxy.conf) ]]; then
      env | grep -i proxy
      echo -e "\e[1;32mproxy configured successfully in the system\e[0m"
      echo -e "\e[1;32mGetting Started Guide : https://docs.docker.com/get-started/\e[0m"
   fi
   echo "intel123" | sudo systemctl daemon-reload
   sudo systemctl restart docker
fi
