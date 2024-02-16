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

#Installing social-distancing-for-retail-settings

echo "Installing social-distancing-for-retail-settings ..."

echo -e "\e[1;36mThis will take couple of minutes ......\e[0m"

pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo 0bc6f800-f667-464d-af07-9ad7fc03606b | $HOME/.local/bin/edgesoftware install social-distancing-for-retail-settings 627a09c506338088f3910d81

echo -e "\e[1;34mSocial_Distancing_for_Retail_Settings_<version> folder is downloaded successfully in Workload folder\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf social-distancing-for-retail-settings RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-implementation/social-distancing-for-retail-settings.html\e[0m\n"


