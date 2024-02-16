#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the terraform is present in the system
if [[ $(which terraform) && $(terraform --version) ]]; then
        echo -e "\e[1;36mTerraform is already present in the system\e[0m"
else
        echo -e "\e[1;33mInstalling terraform.....This will take few mins...\e[0m"
        sudo apt update -y
        wget https://releases.hashicorp.com/terraform/1.2.8/terraform_1.2.8_linux_amd64.zip
        unzip terraform_1.2.8_linux_amd64.zip
        sudo mv terraform /usr/local/bin
        rm terraform_1.2.8_linux_amd64.zip

        #Checking if the terraform is installed successfully
        if [[ $(which terraform) && $(terraform --version) ]]; then
                terraform_version=$(terraform --version)
                echo -e "\e[1;32mSucessfully installed Terraform : $terraform_version \e[0m"
        fi
fi
