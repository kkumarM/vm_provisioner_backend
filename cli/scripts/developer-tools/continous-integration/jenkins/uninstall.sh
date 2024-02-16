#!/bin/bash
  
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


if [[ $(jenkins --version) ]]; then
         echo -e "\e[1;32muninstalling jenkins...........\e[0m"
         sudo systemctl stop jenkins
         sudo apt remove jenkins -y
         echo -e "\e[1;32m\njenkins uninstalled successfully\e[0m"

     else
         echo -e "\e[1;32mjenkins is not present in the system,kindly install the jenkins through 'dc_cli'\e[0m"
fi

