#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the atom is present in the system
if [[ $(which atom) && $(atom --version) ]]; then
        echo -e "\e[1;36matom is already installed in the system\e[0m"
else
        echo -e "\e[1;33mInstalling atom.....This will take few mins...\e[0m"
        echo 'intel123' | sudo apt update
        sudo apt install software-properties-common apt-transport-https wget
        wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"
        sudo apt install atom
        #Checking if the atom is installed successfully
        if [[ $(which atom) && $(atom --version) ]]; then
		atom_version=$(atom --version | grep Atom | awk '{print $3}')
                echo -e "\e[1;32mSuceessfully installed Atom : $atom_version \e[0m"
		echo -e "\e[1;32mGetting Started Guide : https://www.codecademy.com/article/f1-text-editors\e[0m"
        fi
fi

