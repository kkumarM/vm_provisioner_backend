#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the vscode is already present in the system
if [[ $(which code) && $(code --version) ]]; then
        code_version=$(code --version | head -n 1)
        echo -e "\e[1;36mvscode : $code_version is already present in the system\e[0m"
else
        echo -e "\e[1;33mInstalling Vscode....This might take few mins....\e[0m"
        echo 'intel123' | sudo apt-get update
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo chmod +x packages.microsoft.gpg
        sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        sudo rm -f packages.microsoft.gpg
        sudo apt-get install apt-transport-https
        sudo apt-get update
        sudo apt-get install code
        #Checking if the vscode installed suceessfully or not
        if [[ $(which code) && $(code --version) ]]; then
                code_version=$(code --version | head -n 1)
                echo -e "\e[1;32mSuccessfully installed vscode : $code_version \e[0m"
		echo -e "\e[1;32mGetting Started Guide : https://code.visualstudio.com/docs/introvideos/basics\e[0m"
        fi
fi
