#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


if [[ $(pip --version) ]]; then
         echo -e "\e[1;32mpip3 is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling pip3\e[0m"
         sudo apt-get update
         sudo apt-get -y install python3-pip
fi

if [[ $(sudo pip3 show scikit-learn) ]]; then
         echo -e "\e[1;32mscikit-learn is already installed in the system\e[0m"
     else
         echo -e "\e[1;32m********Installing scikit-learn********\e[0m"
         sudo pip3 install -U scikit-learn
	 echo -e "\e[1;32mInstalled scikit-learn successfully\e[0m"
fi

