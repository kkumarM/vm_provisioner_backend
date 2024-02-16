#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the ansible is installed in the system
if ! [[ $(which ansible) && $(ansible --version) ]]; then
        echo -e "\e[1;36mansible is not installed in the system\e[0m"
else
        #uninstalling ansible
        echo -e "\e[1;33mUninstalling ansible....Please wait....\e[0m"
        sudo apt-get purge ansible -y
        sudo apt autoremove ansible -y	
        if ! [[ $(which ansible) && $(ansible --version) ]]; then
                echo -e "\e[1;32mansible uninstalled successfully\e[0m"
        fi
fi

