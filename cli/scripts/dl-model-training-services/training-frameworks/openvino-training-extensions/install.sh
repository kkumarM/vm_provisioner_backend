#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


#checking git
if [[ $(which git) && $(git --version) ]]; then
         echo -e "\e[1;36mgit installed in the system\e[0m"
     else
         echo -e "\e[1;36mInstalling git....\e[0m"
         sudo apt-get install git -y
fi

#installing dataset
if !(git clone https://github.com/openvinotoolkit/training_extensions.git) then
   exit 1
   echo -e"\e[1;32mgit is failing check with version or with the git link\e[0m"
else
    echo -e  "\e[1;32mSuccessfully cloned training extension under the folder 'training_extensions'\e[0m"
    cd training_extensions
    git submodule update --init --recursive
    echo -e "\e[1;32mInstalling prerequisites.....\e[0m"
    sudo apt-get install python3-pip python3-venv
    echo -e "\e[1;32m\nprerequisites installed\e[0m"
    echo -e "\e[1;32m\nopenvino-training-extension is installed under the folder training_extensions\e[0m"
    echo -e "\e[1;33m\nSearch for available scripts that create python virtual environments for different task types using below command:\e[0m"
    echo -e "\e[1;34m\ncommand:find external/ -name init_venv.sh\e[0m"
    echo -e "\e[1;35m\nInorder to further continue working with training-extension follow the below mentioned link:\nhttps://github.com/openvinotoolkit/training_extensions/blob/develop/QUICK_START_GUIDE.md\e[0m"

fi



echo -e "\e[1;31mFor further queries please follow below URL\e[0m"


echo -e "\e[1;32mhttps://github.com/openvinotoolkit/training_extensions\e[0m"
