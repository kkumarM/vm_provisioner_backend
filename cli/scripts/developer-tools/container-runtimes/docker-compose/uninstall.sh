#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the docker-compose is installed in the system
if ! [[ $(which docker-compose) && $(docker-compose --version) ]]; then
        echo -e "\e[1;36mDocker Compose is not installed in the system\e[0m"
else
        #Uninstalling docker-compose
        echo -e "\e[1;33mUninstalling docker-compose...Please wait...\e[0m"
        echo 'intel123' | sudo rm /usr/local/bin/docker-compose
        sudo apt remove docker-compose
        sudo apt autoremove
        #Checking if the docker-compose is uninstalled
        if ! [[ $(which docker-compose) && $(docker-compose --version) ]]; then
                echo -e "\e[1;32mUninstalled docker-compose\e[0m"
        fi
fi
