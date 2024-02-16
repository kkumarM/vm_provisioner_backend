#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the ansible is present in the system
if [[ $(which ansible) && $(ansible --version) ]]; then
        echo -e "\e[1;36mansible is already present in the system\e[0m"
else
        echo -e "\e[1;33mInstalling ansible.....This will take few mins...\e[0m"
	sudo apt-get update -y
        sudo apt-get install software-properties-common -y
        sudo add-apt-repository --yes --update ppa:ansible/ansible -y
        sudo apt install ansible -y
        #Checking if the ansible is installed successfully
        if [[ $(which ansible) && $(ansible --version) ]]; then
                ansible_version=$(ansible --version | grep ansible | awk '{print $3}')
                echo -e "\e[1;32mSuceessfully installed Ansible : $ansible_version \e[0m"
        fi
fi
