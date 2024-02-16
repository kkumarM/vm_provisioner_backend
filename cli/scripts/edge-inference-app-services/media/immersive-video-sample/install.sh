#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo "Checking OS_VERSION"

OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo "System OS : $OS_VERSION"

if [[ $OS_VERSION != "18.04" ]]; then
        echo -e "\e[1;32m\nThe application only supports Ubuntu18 OS. Please select the specified OS for the application\e[0m"
        echo -e "\e[1;36m\nExiting the MarketPlace component installation.....\e[0m"
        exit 1

fi

#Checking if the git is present or not
if [[ $(which git) && $(git --version) ]]; then
        echo -e "\e[1;34m\nGit is already installed\e[0m"
else
        echo -e "\e[1;36mGit is not installed\e[0m"
        sudo apt-get update
        sudo apt-get install git
fi

#Clone the git repo
git clone https://github.com/OpenVisualCloud/Immersive-Video-Sample.git
success=$?
if [[ $success -eq 0 ]];
then
    echo -e "\e[1;33mRepository successfully cloned.\e[0m"
else
    echo -e "\e[1;32mSomething went wrong!\e[0m"
fi

