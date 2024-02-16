#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the docker-compose is present in the system
if [[ $(which docker-compose) && $(docker-compose --version) ]]; then
   compose_version=$(docker-compose --version | awk {'print $3'})
   echo -e "\e[1;36mdocker-compose : $compose_version is already installed in the system\e[0m"
else
   echo -e "\e[1;33mInstalling docker-compose....This might take few mins....\e[0m"
   echo 'intel123' | sudo apt-get update
   sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   #Checking if the docker-compose installed in the system
   if [[ $(which docker-compose) && $(docker-compose --version) ]]; then
      compose_version=$(docker-compose --version | awk {'print $3'})
      echo -e "\e[1;32mSuccessfully installed docker-compose : $compose_version\e[0m"
      echo -e "\e[1;32mGetting Started Guide : https://docs.docker.com/compose/gettingstarted/\e[0m"
   fi
fi
