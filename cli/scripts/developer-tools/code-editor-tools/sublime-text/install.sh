#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the Sublime-Text is present in the system
if [[ $(which subl) && $(subl --version) ]]; then
        subl_version=$(subl --version)
        echo -e "\e[1;36m$subl_version is already installed in the system\e[0m"
else
        echo -e "\e[1;33mInstalling Sublime-Text.....This might take few mins...\e[0m"
        echo "intel123" | sudo apt update
        sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
        curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
        sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
        sudo apt update
        sudo apt install sublime-text
        #Checking if the Sublime-Text is installed successfully
        if [[ $(which subl) && $(subl --version) ]]; then
                subl_version=$(subl --version)
                echo -e "\e[1;32mSucessfully installed $subl_version \e[0m"
		echo -e "\e[1;32mGetting Started Guide : https://www.loginradius.com/blog/engineering/beginners-guide-for-sublime-text/\e[0m"
        fi
fi
