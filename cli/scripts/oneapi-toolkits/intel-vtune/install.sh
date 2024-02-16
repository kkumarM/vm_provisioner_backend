#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo -e "\e[1;33mInstalling intel/oneapi-vtune:latest...This might take few mins...\e[0m"
sudo docker pull intel/oneapi-vtune:latest
echo -e "\e[1;32m***********intel/oneapi-vtune:latest installed successfully**************\e[0m"
echo -e "\e[1;33mTo view the image,run the below command:\e[0m"
echo -e "\e[1;36msudo docker images\e[0m"

echo -e "\e[1;33m\nFollow below url to reference:\e[0m"
echo -e "\e[1;34mhttps://www.intel.com/content/www/us/en/developer/articles/containers/oneapi-vtune.html\e[0m"
