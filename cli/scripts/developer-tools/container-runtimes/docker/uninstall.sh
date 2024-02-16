#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the docker is installed
if ! [[ $(which docker) && $(docker --version) ]]; then
        echo -e "\e[1;36mDocker is not installed in the system\e[0m"
else
        #Uninstalling the docker
	echo -e "\e[1;33mUninstalling docker... This might take few mins...\e[0m"
        echo "intel123" | sudo -S systemctl stop docker.socket
        sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
        sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
        #sudo rm /etc/apt/keyrings/docker.gpg
        sudo rm -rf /var/lib/docker /etc/docker
        if [[ -f /etc/apparmor.d/docker ]]; then
                sudo rm /etc/apparmor.d/docker
        fi
        sudo groupdel docker
        sudo rm -rf /var/run/docker.sock
        #Checking if the docker is uninstalled
        if ! [[ $(which docker) && $(docker --version) ]]; then
                echo -e "\e[1;32mDocker uninstalled Successfully\e[0m"
        fi
fi
