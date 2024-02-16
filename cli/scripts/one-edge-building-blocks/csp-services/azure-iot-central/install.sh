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

if [[ $(echo $http_proxy) || $(echo $https_proxy) ]]; then
        echo "installing......."
        sudo chmod 777 /etc/environment
        sudo echo "http_proxy=http://proxy-dmz.intel.com:911
        https_proxy=http://proxy-dmz.intel.com:911
        HTTP_PROXY=http://proxy-dmz.intel.com:911
        HTTPS_PROXY=http://proxy-dmz.intel.com:91
        tp_proxy=http://proxy-dmz.com:911
        NO_PROXY=localhost,127.0.0.1
        no_proxy=localhost,127.0.0.1" > /etc/environment
        source /etc/environment
else

        echo "proxy setting are done"
fi


#Installing Proxy settings for Openvino

#echo "Installing Proxy settings for Openvino"

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

echo -e "\e[1;32m***************Installing connect_devices_to_azure_iot************\e[0m"

echo -e "\e[1;36m\nThis will take couple of minutes .....\e[0m"

sudo pip3 install onnx==1.7.0

pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo f4c48b37-d307-4df3-ba84-7f5058379476 | $HOME/.local/bin/edgesoftware install connect_devices_to_azure_iot 61a0a73dd8ecccee5592dd8a

echo -e "\e[1;34mconnect-devices-to-azure-iot folder is downloaded successfully\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nconnect-devices-to-azure-iot installed suceessfully...\e[0m"
echo -e "\e[1;36mRefer below URL for the reference\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/technical/connect-devices-to-azure-iot.html\e[0m\n"

