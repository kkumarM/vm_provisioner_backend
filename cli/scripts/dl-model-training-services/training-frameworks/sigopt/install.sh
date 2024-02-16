#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#installing and checking python 3 to be installed
if [[ $(python --version >=3.6) ]]; then
         echo -e "\e[1;32mpython3 is installed\e[0m"
     else
         echo -e "\e[1;32mInstall python version greater than 3.6\e[0m"
fi

#installing pip3 and checking for the pip3 installation

if [[ $(pip --version) ]]; then
         echo -e "\e[1;32mpip3 is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling pip3\e[0m"
         sudo apt-get update
	 sudo apt-get -y install python3-pip
fi

#installing sigopt 
if [[ $(sigopt version) ]]; then
         echo -e "\e[1;32msigopt is already installed in the system\e[0m"
     else
         echo -e "\e[1;32mInstalling sigopt....\e[0m"
         sudo pip3 install sigopt
	 echo -e "\e[1;32mSigopt installed successfully\e[0m"
	 echo -e "\e[1;34m================================================================\e[0m"
	 echo -e "\e[1;32mTo start using sigopt run enable script and follow further steps\e[0m"
	 echo -e "\e[1;34m================================================================\e[0m"

fi



echo -e "\e[1;31mFor further queries please follow below URL\e[0m"

echo -e "\e[1;32mhttps://docs.sigopt.com/\e[0m"
