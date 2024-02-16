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
        echo "Git is already installed"
else
        echo "Git is not installed"
        sudo apt-get update
        sudo apt-get install git
fi

#Clone the git repo
git clone https://github.com/OpenVisualCloud/CDN-Transcode-Sample.git
success=$?
if [[ $success -eq 0 ]];
then
    echo "Repository successfully cloned."
else
    echo "Something went wrong!"
fi


#Checking cmake is present or not
if [[ $(which cmake) && $(cmake --version) ]]; then
	echo "cmake is already installed"
else
	echo "cmake is not installed"
	sudo apt-get update
	sudo apt install cmake
fi

#Checking m4 is present or not

if [[ $(which m4) && $(m4 --version) ]]; then
        echo "m4 is already installed"
else
        echo "m4 is not installed"
        sudo apt-get update
        sudo apt-get install -y m4
fi

#Checking m4 is present or not

if [[ $(which wget) && $(wget --version) ]]; then
        echo "wget is already installed"
else
        echo "wget is not installed"
        sudo apt-get update
        sudo apt-get install -y wget
fi

#Checking gawk is present or not

if [[ $(which gawk) && $(gawk --version) ]]; then
        echo "gawk is already installed"
else
        echo "gawk is not installed"
	sudo apt-get install python-software-properties
        sudo add-apt-repository ppa:schot/gawk /n
        sudo apt-get update
        sudo apt-get install -y  gawk
fi

#Checking gawk is present or not

if [[ $(which helm) && $(helm --version) ]]; then
        echo -e "\e[1;32mhelm is already installed\e[0m"
else
        echo -e "\e[1;31mhelm is not installed\0[0m"
	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
	chmod 700 get_helm.sh
	./get_helm.sh
fi


#making build

cd CDN-Transcode-Sample

mkdir build

cd build

cmake ..   

make

echo -e "\e[1;32mCreating CDN Transcode Sample RI\e[0m"

echo -e "\e[1;34mThis will take few minutes...Please wait....\e[0m"

make update

make volume

make start_helm

kubectl get pods

echo -e "\e[1;36mCDN Transcode Sample RI created\e[0m"

echo -e "Point your browser to \e[1;32mhttps://<your-host>\e[0m to watch the list of video clips"


