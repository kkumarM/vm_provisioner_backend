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

#Installing edge-insights-for-industrial

sudo apt-get install expect -y

echo "Installing edge-insights-for-industrial ..."

echo -e "\e[1;34mThis will take couple of minutes......\e[0m"

pip3 install --upgrade pip --user && pip3 install edgesoftware --user

/usr/bin/expect -c '
set timeout -1
spawn $::env(HOME)/.local/bin/edgesoftware install edge-insights-for-industrial 6272959206338088f3910efe
expect "for intel:" {send "intel123\n"}
expect "download:" {send "196cc5ee-e133-4b1a-b6c7-fda621e1bc17\n"}
expect "Production mode:" {send "yes\n"}
expect EOF'

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf edge-insights-for-industrial RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/develop/documentation/edge-insights-industrial-doc/top.html\e[0m\n"
