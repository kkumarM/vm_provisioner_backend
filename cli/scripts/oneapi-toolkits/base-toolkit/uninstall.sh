#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo -e "\e[1;33mUninstalling intel/oneapi-basekit:latest...\e[0m"
sudo docker rmi intel/oneapi-basekit:latest
echo -e "\e[1;32m***********Uninstalled intel/oneapi-basekit successfully**************\e[0m"
