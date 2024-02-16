#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


export HOST_IP=$(hostname -I | cut -d' ' -f1)
echo -e "\e[1;32mSonoma-creek is pre-installed in the system and can be accessed using below mentioned URL\e[0m"
echo -e "\e[1;32mhttps://10.224.79.48/\e[0m"
echo -e "\e[1;33m\nKindly use the below login credentials to login and create your own member under 'add member' of team to use sonoma-creek\e[0m"
echo -e "\e[1;34m===============================\e[0m"
echo -e "\e[1;34mMailId:Admin@intel.com\e[0m"
echo -e "\e[1;34mcredential:admin123\e[0m"
echo -e "\e[1;34m===============================\e[0m"


echo -e "\e[1;32mFor further queries please follow below URL\e[0m"

echo -e "\e[1;35m\nhttps://10.224.79.48/docs/guide/get-started/introduction.html\e[0m"


