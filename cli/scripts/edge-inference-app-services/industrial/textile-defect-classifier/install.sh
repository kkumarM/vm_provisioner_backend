#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking OS_VERSION

echo "Checking OS_VERSION"

OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo "System OS : $OS_VERSION"

if [[ $OS_VERSION != "18.04" ]]; then
        echo -e "\e[1;32mThe application only supports Ubuntu18 OS. Please select the specified OS for the application\e[0m"
        echo -e "\e[1;36mExiting the MarketPlace component installation.....\e[0m"
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

#echo "installing proxy settings for openvino"

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

#Installing Textile-defect-classifier
echo "Installing Textile-defect-classifier ..."

echo -e "\e[1;34mThis will take couple of minutes......\e[0m"

sudo pip3 install onnx==1.7.0

pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo 8f4db493-0381-4391-8ec8-2af1b450ad45 | $HOME/.local/bin/edgesoftware install textile-defect-classifier 61703650d8ecccee55019b27

echo -e "\e[1;34mTextile-Defect-Classifier_<version> folder is downloaded successfully in Workload folder\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf Textile-defect-classifier RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-implementation/textile-defect-classifier.html\e[0m\n"
