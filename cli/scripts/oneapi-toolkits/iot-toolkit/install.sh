#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo -e "\e[1;33mInstalling intel/oneapi-iotkit:latest\e[0m"
sudo docker pull intel/oneapi-iotkit:latest
echo -e "\e[1;32m***********Installed intel/oneapi-iotkit:latest successfully**************\e[0m"
echo -e "\e[1;33mTo view the image, run the below command\e[0m"
echo -e "\e[1;36msudo docker images\e[0m"

echo -e "\e[1;33m\nFollow below url to reference:\e[0m"
echo -e "\e[1;34mhttps://www.intel.com/content/www/us/en/developer/articles/containers/oneapi-iot-toolkit.html\e[0m"
