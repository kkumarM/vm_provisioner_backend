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
git clone https://github.com/OpenVisualCloud/Ad-Insertion-Sample.git 
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

cd Ad-Insertion-Sample
mkdir build
cd build
cmake ..    
make

make dash

make hls

make addash

make adhls

echo -e "\e[1;32mCreating Ad-Insertion RI\e[0m"

echo -e "\e[1;34mThis will take few minutes...Please wait....\e[0m"

make update

make volume

make start_kubernetes

kubectl get pods

echo -e "\e[1;36mAd-Insertion RI created\e[0m"

echo -e "Launch your browser and point to \e[1;32mhttps://<hostname>\e[0m to see the sample UI. Double click on any video clip to play the stream and see ADs got inserted during playback."




