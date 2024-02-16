#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the chef is present in the system
if [[ $(which chef) && $(chef --version) ]]; then
        echo -e "\e[1;36mchef is already present in the system\e[0m"
else
        echo -e "\e[1;33mInstalling chef.....This will take few mins...\e[0m"
	sudo apt update -y
	wget https://packages.chef.io/files/stable/chef-workstation/21.10.640/ubuntu/20.04/chef-workstation_21.10.640-1_amd64.deb
	sudo dpkg -i chef-workstation_21.10.640-1_amd64.deb

        #Checking if the chef is installed successfully
        if [[ $(which chef) && $(chef --version) ]]; then
                chef_version=$(chef --v)
                echo -e "\e[1;32mSucessfully installed Chef : $chef_version \e[0m"
        fi
fi
