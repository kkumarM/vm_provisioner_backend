#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the Sublime-Text is installed in the system
if ! [[ $(which subl) && $(subl --version) ]]; then
        echo -e "\e[1;36mSublime-Text is not installed in the system\e[0m"
else
        #uninstalling Sublime-Text
        echo -e "\e[1;33mUninstalling Sublime-Text....Please wait....\e[0m"
        echo 'intel123' | sudo -S apt-get purge sublime-text -y
        sudo apt-get remove sublime-text
        if ! [[ $(which subl) && $(subl --version) ]]; then
                echo -e "\e[1;32mSublime-Text uninstalled successfully\e[0m"
        fi
fi
