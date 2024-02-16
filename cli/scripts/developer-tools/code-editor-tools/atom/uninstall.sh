#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the atom is installed in the system
if ! [[ $(which atom) && $(atom --version) ]]; then
        echo -e "\e[1;36matom is not installed in the system\e[0m"
else
        #uninstalling atom
        echo -e "\e[1;33mUninstalling atom....Please wait....\e[0m"
        echo 'intel123' | sudo apt purge atom -y
        sudo apt remove atom
        sudo rm /usr/local/bin/atom
        sudo rm /usr/local/bin/apm
        rm -rf ~/atom
        rm -rf ~/.atom
        rm -rf ~/.config/Atom-Shell
        sudo rm -rf /usr/local/share/atom/
        if ! [[ $(which atom) && $(atom --version) ]]; then
                echo -e "\e[1;32matom uninstalled successfully\e[0m"
        fi
fi

