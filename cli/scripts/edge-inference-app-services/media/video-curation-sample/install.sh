#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo -e "\e[1;33mChecking OS_VERSION\e[0m"

OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo "System OS : $OS_VERSION"

if [[ $OS_VERSION != "18.04" ]]; then
        echo -e "\e[1;32m\nThe application only supports Ubuntu18 OS. Please select the specified OS for the application\e[0m"
        echo -e "\e[1;36m\nExiting the MarketPlace component installation.....\e[0m"
        exit 1

fi

#Checking if the git is present or not
if [[ $(which git) && $(git --version) ]]; then
        echo -e "\e[1;34mGit is already installed\e[0m"
else
        echo -e "\e[1;31mGit is not installed\e[0m"
        sudo apt-get update
        sudo apt-get install git
fi

#Clone the git repo
git clone https://github.com/OpenVisualCloud/Video-Curation-Sample.git
success=$?
if [[ $success -eq 0 ]];
then
    echo "Repository successfully cloned."
else
    echo "Something went wrong!"
fi

#Checking cmake is present or not
if [[ $(which cmake) && $(cmake --version) ]]; then
	echo "Make is already installed"
else
	echo "Make is not installed"
	sudo apt-get update
	sudo apt install cmake
fi

#making build

cd Video-Curation-Sample
mkdir build
cd build
cmake ..    
make

echo -e "\e[1;32mCreating Video Curation Sample RI\e[0m"

echo -e "\e[1;34mThis will take few minutes...Please wait....\e[0m"

make update

make start_kubernetes

kubectl get pods

echo -e "\e[1;36mVideo Curation Sample RI  created\e[0m"


