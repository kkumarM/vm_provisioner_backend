#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


#checking wget
if [[ $(which wget) && $(wget --version) ]]; then
         echo -e "\e[1;36mwget installed in the system\e[0m"
     else
         echo -e "\e[1;36mInstalling wget....\e[0m"
         sudo apt install wget -y
fi

#installing Face-Mask-Detection
if !(wget -r -nH --cut-dirs=5 --no-parent  https://github.com/prajnasb/observations/tree/master/experiements/data) then
   exit 1
   echo -e"\e[1;32mgit is failing check with version or with the git link\e[0m"
else
    echo -e  "\e[1;32mSuccess\e[0m"
    sudo rm -rf robots.txt
    echo -e "\e[1;32m'Face Mask Detection' installed\e[0m"
    echo -e "\e[1;32m\n'Face Mask Detection' installed successfully and downloaded under the folder name 'data'\e[0m"

fi


echo -e "\e[1;31mFor further queries please follow below URL\e[0m"


echo -e "\e[1;32mhttps://github.com/openvinotoolkit/openvino/tree/master/tools\e[0m"
