#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the chef is installed in the system
if ! [[ $(which chef) && $(chef --version) ]]; then
        echo -e "\e[1;36mchef is not installed in the system\e[0m"
else
        #uninstalling chef
        echo -e "\e[1;33mUninstalling chef....Please wait....\e[0m"
	sudo dpkg -P chef-workstation
	sudo rm -rf chef-workstation_21.10.640-1_amd64.deb
        if ! [[ $(which chef) && $(chef --version) ]]; then
                echo -e "\e[1;32mchef uninstalled successfully\e[0m"
        fi
fi
