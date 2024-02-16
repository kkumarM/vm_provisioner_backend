#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking if the git is present or not
if [[ $(which git) && $(git --version) ]]; then
        echo "Git is already installed"
else
        echo "Git is not installed"
        sudo apt-get update
        sudo apt-get install git
fi

#Clone the git repo
git clone https://github.com/OpenVisualCloud/Smart-City-Sample.git 
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

#Checking m4 is present or not

if [[ $(which m4) && $(m4 --version) ]]; then
        echo "m4 is already installed"
else
        echo "m4 is not installed"
        sudo apt-get update
        sudo apt-get install -y m4
fi

#Checking wget is present or not

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

#making build

cd Smart-City-Sample
mkdir build
cd build
cmake ..    
make

echo -e "\e[1;32mCreating Smart City RI\e[0m"

echo -e "\e[1;34mThis will take few minutes...Please wait....\e[0m"

make update

make start_kubernetes

kubectl get pods

echo -e "\e[1;36mSmart City RI created\e[0m"

echo -e "Launch your browser and point to \e[1;32mhttps://<hostname>\e[0m to see the sample UI."



