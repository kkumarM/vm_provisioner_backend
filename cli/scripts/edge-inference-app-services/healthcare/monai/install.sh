#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking if the git is present or not

echo "checking the GIT Version"

if [[ $(which git) && $(git --version) ]]; then
        echo "Git is already installed"
else
        echo "Git is not installed"
        sudo apt-get update
        sudo apt-get install git
fi

#Clone the git repo

git clone https://github.com/Project-MONAI/MONAI.git
success=$?
if [[ $success -eq 0 ]];
then
    echo "Repository successfully cloned."
else
    echo "Something went wrong!"
fi

#Checking pip installation
echo "checking for the pip installation"
if [[ $(which pip) && $(pip --version) ]]; then
         echo "pip is installed in the system"
     else
         echo "Install pip-package"
         sudo apt update
         sudo apt install python3-pip -y
   fi

echo "Installing MONAI"

pip install monai

echo -e "\e[1;34mMONAI folder is downloaded successfully in Workload folder\e[0m\n"

#Check RI is installed sucessfully

echo -e "\e[1;32m\nIf RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://github.com/Project-MONAI/MONAI\e[0m\n"
