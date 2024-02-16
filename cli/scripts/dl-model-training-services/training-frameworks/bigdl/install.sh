#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Go to home directory
cd ~

#checking wget installation
if [[ $(which wget) && $(wget --version) ]]; then
         echo -e "\e[1;36mwget installed in the system\e[0m"
     else
         echo -e "\e[1;36mInstalling wget....\e[0m"
         sudo apt install wget -y
fi

#installing anaconda
echo -e "\e[1;36mInstalling Anaconda....\e[0m"
if !(wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh) then
   exit 1
   echo -e"\e[1;32mwget is failing check with version or with the wget link\e[0m"
else
    echo -e  "\e[1;32mSuccess\e[0m"
    bash Anaconda3-4.2.0-Linux-x86_64.sh -b -p ~/anaconda
    rm Anaconda3-4.2.0-Linux-x86_64.sh
    echo 'export PATH="/home/intel/anaconda3:$PATH"' >> ~/.bashrc
    # Refresh basically
    source .bashrc
    echo -e "\e[1;32mActivating the installation..............\e[0m"
    source ~/.bashrc
    export CONDA_ALWAYS_YES="true"
    conda update conda
    echo -e "\e[1;32mCreating virtual Environment......\e[0m"
    conda create -n my_env
    source activate my_env
fi

#checking pip installation
if [[ $(pip3 --version) ]]; then
         echo -e "\e[1;32mpip3 is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling pip3\e[0m"
         sudo apt-get update
         sudo apt-get -y install python3-pip
fi

#bigdl installation
if [[ $(bigdl version) ]]; then
         echo -e "\e[1;32mBigdl is already installed in the system\e[0m"
     else
         echo -e "\e[1;32mInstalling bigdl....\e[0m"
         sudo pip3 install bigdl
         echo -e "\e[1;32mInstalled bigdl successfully\e[0m"

fi

unset CONDA_ALWAYS_YES


echo -e "\e[1;31mFor further queries please follow below URL\e[0m"


echo -e "\e[1;32mhttps://github.com/intel-analytics/BigDL\e[0m"
