#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking OS_VERSION

echo "Checking OS_VERSION"

OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo "System OS : $OS_VERSION"

if [[ $OS_VERSION != "18.04" ]]; then
        echo -e "\e[1;32mThe application only supports Ubuntu18 OS. Please select the specified OS for the application\e[0m\n"
        echo -e "\e[1;36mExiting the MarketPlace component installation.....\e[0m\n"
        exit 1

fi

#Installing real-time-sensor-fusion-for-loss-detection

echo "Installing real-time-sensor-fusion-for-loss-detection ..."

echo -e "\e[1;36m\nThis will take couple of minutes....\e[0m"

pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo 8ecf6818-1c42-40bf-a5c5-2d0043575ffb | $HOME/.local/bin/edgesoftware install real-time-sensor-fusion-for-loss-detection 61712992d8ecccee5521c566

echo -e "\e[1;34mReal_Time_Sensor_Fusion_for_Loss_Detection_<version> folder is downloaded successfully in Workload folder\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf real-time-sensor-fusion-for-loss-detection RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-implementation/real-time-sensor-fusion-for-loss-detection.html\e[0m\n"
