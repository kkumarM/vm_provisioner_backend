#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


if [[ $(sudo pip3 --version) ]]; then
         echo -e "\e[1;32mpip3 is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling pip3\e[0m"
         sudo apt-get update
         sudo apt-get -y install python3-pip
fi

echo -e "\e[1;32mInstalling PyTorch-Model-Zoo..............\e[0m"
sudo pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu
echo -e "\e[1;32m\nsuccessfully installed\e[0m"
echo -e "\e[1;34mKindly refer the below link to get started with PyTorch-Model-Zoo\e[0m"
echo -e "\e[1;35m\nhttps://pytorch.org/get-started/locally/\e[0m"

