#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if jupyter notebook is installed in the system
if [[ $(which jupyter-notebook) && $(jupyter-notebook --version) ]]; then
        notebook_version=$(jupyter-notebook --version)
        echo -e "\e[1;36mjupyter notebook : $notebook_version is already installed in the system\e[0m"
else
        #Installing jupyter notebook
        echo -e "\e[1;33mInstalling jupyter notebook....This might take few mins\e[0m"
        echo 'intel123' | sudo -S apt-get update
        sudo apt-get install jupyter-notebook -y
        #Checking if jupyter notebook is installed
        if [[ $(which jupyter-notebook) && $(jupyter-notebook --version) ]]; then
                notebook_version=$(jupyter-notebook --version)
                echo -e "\e[1;32mjupyter notebook : $notebook_version is successfully installed\e[0m"
		echo -e "\e[1;32mGetting Started Guide : https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/\e[0m"
        fi
fi
