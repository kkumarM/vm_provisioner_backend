#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the notepad-plus-plus is installed in the system
if ! [[ $(which notepad-plus-plus) && $(snap list | awk '/notepad-plus-plus/ {print $2}') ]]; then
        echo -e "\e[1;36mnotepad++ is not installed in the system\e[0m"
else
        #uninstalling notepad++
        echo -e "\e[1;33mUninstalling notepad++....Please wait....\e[0m"
        echo 'intel123' | sudo -S snap disable notepad-plus-plus
        sudo snap remove notepad-plus-plus
        #Checking if notepad++ uninstalled
	if ! [[ $(which notepad-plus-plus) && $(snap list | awk '/notepad-plus-plus/ {print $2}') ]]; then
                echo -e "\e[1;32mnotepad++ uninstalled successfully\e[0m"
        fi
fi
