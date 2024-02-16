#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


sudo pip3 uninstall -y bigdl
echo -e "\e[1;32mBigdl uninstalled successfully\e[0m"
source deactivate my_env
echo -e "\e[1;32mDeactivated virtual environment\e[0m"
sudo rm -rf ~/anaconda
echo -e "\e[1;32mAnaconda is completely uninstalled\e[0m"

