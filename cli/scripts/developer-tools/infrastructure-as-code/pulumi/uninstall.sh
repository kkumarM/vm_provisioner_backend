#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the pulumi is installed in the system

$PWD
if ! [[ $(which pulumi) && $(pulumi version) ]]; then
        echo -e "\e[1;36mPulumi is not installed in the system\e[0m"
else
        #uninstalling Pulumi
        echo -e "\e[1;33mUninstalling Pulumi....Please wait....\e[0m"

        sudo rm -rf $PWD/.pulumi/

        if ! [[ $(which pulumi) && $(pulumi version) ]]; then
                echo -e "\e[1;32mPulumi uninstalled successfully\e[0m"
        fi
fi

