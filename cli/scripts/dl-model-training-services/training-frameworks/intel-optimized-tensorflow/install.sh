#!/bin/bash


# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


if [[ $(sudo pip3 show intel-tensorflow) ]]; then
         echo -e "\e[1;32mintel-tensorflow is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling intel-tensorflow to download the models\e[0m"
         sudo pip3 install intel-tensorflow==2.9.1
         echo -e "\e[1;32mintel-tensorflow==2.9.1 installed successfully\e[0m"
fi

echo -e "\e[1;31mRefer below URL to get started:\e[0m"

echo -e "\e[1;32mhttps://www.intel.com/content/www/us/en/developer/articles/guide/optimization-for-tensorflow-installation-guide.html\e[0m"
