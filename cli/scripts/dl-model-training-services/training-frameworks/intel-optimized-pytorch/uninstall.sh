#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo -e "\e[1;32mUninstalling pytorch and its extension..........\e[0m"
sudo pip3 uninstall torch torchvision torchaudio -y
sudo pip3 uninstall intel_extension_for_pytorch -y
echo -e "\e[1;32mPytorch and its extension is uninstalled\e[0m"


