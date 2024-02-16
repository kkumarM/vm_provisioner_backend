#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the vscode is installed in the system
if ! [[ $(which code) && $(code --version) ]]; then
        echo -e "\e[1;36mvscode is not installed in the system\e[0m"
else
	#Uninstalling vscode
        code_version=$(code --version | head -n 1)
        echo -e "\e[1;33mUninstalling vscode $code_version\e[0m"
        echo 'intel123' | sudo apt-get remove code -y
        sudo rm -rf $HOME/.config/Code
        sudo rm -rf ~/.vscode
	#Checking if the vscode is uninstalled
        if ! [[ $(which code) && $(code --version) ]]; then
                echo -e "\e[1;32mvscode : $code_version is uninstalled\e[0m"
        fi
fi
