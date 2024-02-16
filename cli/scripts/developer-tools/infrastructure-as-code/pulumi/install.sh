#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the pulumi is present in the system


$PWD
if [[ $(which pulumi) && $(pulumi version) ]]; then
        echo -e "\e[1;36mPulumi is already present in the system\e[0m"
else
        echo -e "\e[1;33mInstalling pulumi.....This will take few mins...\e[0m"
        sudo apt update -y
        
	curl -fsSL https://get.pulumi.com | sh
        
	
	export PATH="$PATH:$PWD/.pulumi/bin"

        #Checking if the pulumi is installed successfully
        if [[ $(which pulumi) && $(pulumi version) ]]; then
                pulumi_version=$(pulumi version)
                echo -e "\e[1;32mSucessfully installed Pulumi : $pulumi_version \e[0m"
        fi
fi
