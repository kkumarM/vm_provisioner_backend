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
        echo -e "\e[1;32nstalling.......\e[0m"
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

echo -e "\e[1;32m***********Installing aws-cloud-to-edge-pipeline************\e[0m"

echo -e "\e[1;36m\nThis will take couple of minutes .....\e[0m"

sudo pip3 install onnx==1.7.0

pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo 43bd12dd-8e6d-4f3c-b6ad-72153e95f71d | $HOME/.local/bin/edgesoftware install aws_cloud_to_edge_pipeline 617141d4d8ecccee552512ed

echo -e "\e[1;34maws-cloud-to-edge-pipeline folder is downloaded in \home\intel\<username>\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\n*************aws-cloud-to-edge-pipeline installed suceessfully************\e[0m"
echo -e "\e[1;36mRefer below URL for reference\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/technical/aws-cloud-to-edge-pipeline.html\e[0m\n"

