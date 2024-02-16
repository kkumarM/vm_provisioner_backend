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

#Installing automatic-licence-plate-recognition

echo "Installing automatic-licence-plate-recognition ..."

echo -e "\e[1;36mThis will take couple of minutes ......\e[0m"

pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo fe86f27f-7ec8-4550-a964-be67d3d895b5 | $HOME/.local/bin/edgesoftware install automatic-licence-plate-recognition 61f38cca14e68bcc9220ccb8

echo -e "\e[1;34mAutomated_License_Plate_Recognition_<version> folder is downloaded successfully in Workload folder\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf automatic-licence-plate-recognition RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-implementation/automated-license-plate-recognition.html\e[0m\n"
