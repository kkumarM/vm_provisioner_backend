#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking OS_VERSION

echo "Checking OS_VERSION"

OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo "System OS : $OS_VERSION"

if [[ $OS_VERSION != "20.04" ]]; then
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

#Installing edge-to-cloud-bridge-for-microsoft-azure-service.....

echo -e "\e[1;32m**********Installing edge-to-cloud-bridge-for-microsoft-azure-service*************"

echo -e "\e[1;36m\nThis will take couple of minutes .....\e[0m"

sudo pip3 install onnx==1.7.0

pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo 09b326f1-f1a6-4b7a-99bf-764de0ebd7f5 | $HOME/.local/bin/edgesoftware install edge_to_cloud_bridge_for_microsoft_azure_service 626bcd3606338088f3a7f3f9

echo -e "\e[1;34medge_to_cloud_bridge_for_microsoft_azure_service folder is downloaded successfully\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\n***********edge_to_cloud_bridge_for_microsoft_azure_service installed successfully*******\e[0m"
echo -e "\e[1;35m\nFollow the below URL for reference\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/technical/edge-to-cloud-bridge-for-microsoft-azure-service.html\e[0m\n"

