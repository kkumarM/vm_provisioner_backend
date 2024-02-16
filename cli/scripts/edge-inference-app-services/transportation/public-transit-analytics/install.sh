#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking OS_VERSION

echo "Checking OS_VERSION"

OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo "System OS : $OS_VERSION"

if [[ $OS_VERSION != "18.04" ]]; then
        echo -e "\e[1;32m\nThe application only supports Ubuntu18 OS. Please select the specified OS for the application\e[0m"
        echo -e "\e[1;32m\nExiting the MarketPlace component installation.....\e[0m"
        exit 1

fi

#Installing public-transit-analytics

echo "Installing public-transit-analytics ..."

echo -e "\e[1;36m\nThis will take couple of minutes .....\e[0m"
pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo 0d40e20d-ce8a-4b52-98b3-498af48edd60 | $HOME/.local/bin/edgesoftware install public-transit-analytics 61f3aea414e68bcc92254dbb

echo -e "\e[1;34mPublic_Transit_Analytics_<version> folder is downloaded successfully in Workload folder\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf public-transit-analytics RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-implementation/public-transit-analytics.html\e[0m\n"
