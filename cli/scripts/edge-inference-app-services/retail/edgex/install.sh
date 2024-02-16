#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking for Docker installation
echo "checking for docker installation"
if [[ $(which docker) && $(docker --version) ]]; then
         echo "Dockerce is present in the system"
     else
         echo "Install docker from devtool"
   fi

#Checking for docker-compose installation
echo "checking for docker-compose installation"
if [[ $(which docker) && $(docker --version) ]]; then
         echo "Docker-Compose is present in the system"
     else
         echo "Install docker from devtool"
   fi
  
#Running Edgex
echo "Running EdgeX" 

echo -e "\e[1;36m\nThis will take couple of minutes....\e[0m"

curl https://raw.githubusercontent.com/edgexfoundry/edgex-compose/jakarta/docker-compose-no-secty.yml -o docker-compose.yml; docker-compose up -d

docker-compose ps

echo "Edgex Installed sucessfully"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://docs.edgexfoundry.org/2.1/getting-started/quick-start/\e[0m\n"

echo "By running below link data will be shown in json format"
echo -e "\e[1;32m\ncurl http://<hostname>:59880/api/v2/event/device/name/Random-Integer-Device\e[0m\n"
