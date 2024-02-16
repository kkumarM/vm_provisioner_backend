#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

sudo pip3 uninstall tensorflow -y 
echo -e "\e[1;32mtensorflow unistalled\e[0m"
sudo pip3 uninstall openvino-tensorflow -y
echo -e "\e[1;32mopenvino-tensorflow is uninstalled\e[0m"


