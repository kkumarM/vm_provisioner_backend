#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


sudo rm -rf public/
sudo pip3 uninstall openvino-dev==2021.4.2 -y
echo -e "\e[1;32mmodel is uninstalled\e[0m"

