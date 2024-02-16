#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

sudo pip3 uninstall "tensorflow>=2.0.0" -y
sudo pip3 uninstall tensorflow_hub -y
echo -e "\e[1;32mtensorflow_hub uninstalled\e[0m"

