#!/bin/bash
  
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#checking git
if [[ $(which git) && $(git --version) ]]; then
         echo -e "\e[1;36m\ngit installed in the system\e[0m"
     else
         echo -e "\e[1;36m\nInstalling git....\e[0m"
         sudo apt-get install git -y
fi

echo -e "\e[1;32m\nLogin to the 'github.com' with your credentials:\e[0m"
echo -e "\e[1;32m*****************************************************\e[0m"
echo -e "\e[1;34m\nFollow the below url to create workflows in github-actions: \e[0m"
echo -e "\e[1;34mhttps://github.com/features/actions\e[0m"
