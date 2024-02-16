#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking OS_VERSION

echo "Checking OS_VERSION"

OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo "System OS : $OS_VERSION"

if [[ $OS_VERSION != "18.04" ]]; then
        echo -e "\e[1;32m\nThe application only supports Ubuntu18 OS. Please select the specified OS for the application\e[0m"
        echo -e "\e[1;36m\nExiting the MarketPlace component installation.....\e[0m"
        exit 1

fi

#Installing Proxy settings for Openvino

if [[ $(echo $http_proxy) || $(echo $https_proxy) ]]; then
        echo "installing......."
        sudo chmod 777 /etc/environment
        sudo echo "http_proxy=http://proxy-dmz.intel.com:911
        https_proxy=http://proxy-dmz.intel.com:911
        HTTP_PROXY=http://proxy-dmz.intel.com:911
        HTTPS_PROXY=http://proxy-dmz.intel.com:91
        ftp_proxy=http://proxy-dmz.com:911
        NO_PROXY=localhost,127.0.0.1    
        no_proxy=localhost,127.0.0.1" > /etc/environment
        source /etc/environment
else

        echo "proxy setting are done"
fi


#sudo chmod 777 /etc/environment
#sudo echo "http_proxy=http://proxy-dmz.intel.com:911
#https_proxy=http://proxy-dmz.intel.com:911
#HTTP_PROXY=http://proxy-dmz.intel.com:911
#HTTPS_PROXY=http://proxy-dmz.intel.com:911
#ftp_proxy=http://proxy-dmz.com:911
#NO_PROXY=localhost,127.0.0.1                                                                                                  
#no_proxy=localhost,127.0.0.1" > /etc/environment
#source /etc/environment
export no_proxy="localhost,127.0.0.1"

#Installing intelligent-traffic-management

echo "Installing intelligent-traffic-management ..."

echo -e "\e[1;36m\nThis will take couple of minutes .....\e[0m"

sudo pip3 install onnx==1.7.0

pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo ad655e14-66bb-479f-9343-482f0b62e000 | $HOME/.local/bin/edgesoftware install intelligent-traffic-management 61710291d8ecccee551c9463

echo -e "\e[1;34mIntelligent_Traffic_Management_<version> folder is downloaded successfully in Workload folder\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf intelligent-traffic-management RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-implementation/intelligent-traffic-management.html\e[0m\n"
