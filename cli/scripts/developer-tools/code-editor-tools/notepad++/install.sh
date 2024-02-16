#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if notepad++ is installed in the system
if [[ $(which notepad-plus-plus) && $(snap list | awk '/notepad-plus-plus/ {print $2}') ]]; then
        notepad_version=$(snap list | awk '/notepad-plus-plus/ {print $2}')
        echo -e "\e[1;36mnotepad++ : $notepad_version is already installed in the system\e[0m"
else
        #Installing notepad++
        echo -e "\e[1;33mInstalling notepad++....This might take few mins....\e[0m"
        echo 'intel123' | sudo -S apt-get install snapd snapd-xdg-open
        sudo snap install notepad-plus-plus
        #Checking if the notepad++ is installed
        if [[ $(which notepad-plus-plus) && $(snap list | awk '/notepad-plus-plus/ {print $2}') ]]; then
                notepad_version=$(snap list | awk '/notepad-plus-plus/ {print $2}')
                echo -e "\e[1;32mSuccessfully installed notepad-plus-plus : $notepad_version\e[0m"
		echo -e "\e[1;32mGetting Started Guide : https://npp-user-manual.org/docs/getting-started/\e[0m"
        fi
fi
