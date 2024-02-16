#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking OS_VERSION

echo "Checking OS_VERSION"

OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo "System OS : $OS_VERSION"

if [[ $OS_VERSION != "20.04" ]]; then
        echo -e "\e[1;32m\nThe application only supports Ubuntu20 OS. Please select the specified OS for the application\e[0m"
        echo -e "\e[1;36m\nExiting the MarketPlace component installation.....\e[0m"
        exit 1

fi

#Installing proxy settings for openvino

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

#echo "Installing proxy settings for openvino"

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

#Installing brain-tumor-segmentation

echo "Installing brain-tumor-segmentation ..."

sudo pip3 install onnx==1.7.0

pip3 install --upgrade sudo pip --user && pip3 install edgesoftware --user
echo c4ca3793-5316-492c-8c53-bf4266799781 | $HOME/.local/bin/edgesoftware install brain-tumor-segmentation 617b9f97d8ecccee55878c24

echo -e "\e[1;34mBrain-Tumor-Segmentation folder is downloaded successfully in Workload folder\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-implementation/brain-tumor-segmentation.html\e[0m\n"
