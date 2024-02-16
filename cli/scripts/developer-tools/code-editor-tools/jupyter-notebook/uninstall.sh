#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if jupyter notebook is present in the system
if ! [[ $(which jupyter-notebook) && $(jupyter-notebook --version) ]]; then
        echo -e "\e[1;36mjupyter notebook is not installed in the system\e[0m"
else
        #Uninstalling jupyter notebook
        echo -e "\e[1;33mUninstalling jupyter notebook...Please wait...\e[0m"
        echo 'intel123' | sudo -S apt remove jupyter-notebook -y
        sudo apt autoclean && sudo apt autoremove -y
        #Checking if jupyter notebook uninstalled
        if ! [[ $(which jupyter-notebook) && $(jupyter-notebook --version) ]]; then
                echo -e "\e[1;32mUninstalled jupyter notebook\e[0m"
        fi
fi
