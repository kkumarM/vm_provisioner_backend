#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ $(pip3 --version) ]]; then
         echo -e "\e[1;32mpip3 is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling pip3\e[0m"
         sudo apt-get update
         sudo apt-get -y install python3-pip
fi

if [[ $(pip3 show datumaro) ]]; then
         echo -e "\e[1;32mdatumaro is already installed in the system\e[0m"
     else
         echo -e "\e[1;32mInstalling datumaro....\e[0m"
         sudo pip3 install datumaro[default]
	 echo -e "\e[1;32mInstalled datumaro successfully\e[0m"

fi

echo -e "\e[1;31mFor further queries please follow below URL\e[0m"

echo -e "\e[1;32mhttps://github.com/openvinotoolkit/datumaro\e[0m"
