#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


if [[ $(sudo pip3 show pytorch ) ]]; then
         echo -e "\e[1;32mintel-pytorch is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling intel-pytorch to download the models\e[0m"
         sudo pip3 install torch torchvision torchaudio
	 sudo python3 -m pip install intel_extension_for_pytorch 
         echo -e "\e[1;32mintel-pytorch is installed successfully\e[0m"
fi

echo -e "\e[1;31mRefer below URL for further reference\e[0m"

echo -e "\e[1;32mhttps://intel.github.io/intel-extension-for-pytorch/1.11.200/\e[0m"
