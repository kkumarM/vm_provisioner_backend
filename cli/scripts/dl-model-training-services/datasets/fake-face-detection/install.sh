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
if !(git clone https://github.com/SkyThonk/real-and-fake-face-detection.git) then
   exit 1
   echo -e"\e[1;32mgit is failing check with version or with the git link\e[0m"
else
    echo -e  "\e[1;32mSuccess\e[0m"
    echo -e "\e[1;32mfake-face-detection dataset is downloaded successfully\e[0m"
    echo -e "\e[1;32mThe dataset is downloaded under the the foldername 'real-and-fake-face-detection'\e[0m"


fi

echo -e "\e[1;31mfollow below URL for reference\e[0m"

echo -e "\e[1;32mhttps://github.com/SkyThonk/real-and-fake-face-detection\e[0m"
