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

#Installing rotor-bearing-defect-detector
echo 'intel123' | sudo -S apt-get update
sudo apt-get install expect -y
export HOST_IP=$(hostname -I | cut -d' ' -f1)
echo "Installing rotor-bearing-defect-detector ..."

echo -e "\e[1;34mThis will take couple of minutes......\e[0m"

pip3 install --upgrade pip --user && pip3 install edgesoftware --user
/usr/bin/expect -c '
set timeout -1
spawn $::env(HOME)/.local/bin/edgesoftware install rotor-bearing-defect-detector 6170f2ddd8ecccee551a72fa
expect "for intel:" {send "intel123\n"}
expect "download:" {send "dfde7618-2fa5-4f31-a776-22f82dc59c10\n"}
expect "Production mode:" {send "yes\n"}
expect EOF'
echo -e "\e[1;34mRotor_Bearing_Defect_Detector_<version> folder is downloaded successfully in Workload folder\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf rotor-bearing-defect-detector RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-implementation/rotor-bearing-defect-detector.html\e[0m\n"
