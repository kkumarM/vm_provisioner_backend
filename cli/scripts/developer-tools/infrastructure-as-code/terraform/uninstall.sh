#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the terraform is installed in the system
if ! [[ $(which terraform) && $(terraform --version) ]]; then
        echo -e "\e[1;36mTerraform is not installed in the system\e[0m"
else
        #uninstalling Terraform
        echo -e "\e[1;33mUninstalling Terraform....Please wait....\e[0m"
        sudo apt remove terraform -y

        sudo rm -rf /usr/bin/terraform

        sudo rm -rf /usr/local/bin/terraform

        if ! [[ $(which terraform) && $(terraform --version) ]]; then
                echo -e "\e[1;32mTerraform uninstalled successfully\e[0m"
        fi
fi
