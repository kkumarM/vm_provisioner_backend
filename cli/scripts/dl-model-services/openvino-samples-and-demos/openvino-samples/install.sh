#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


# Creating a symbolic link 

if [ -d /opt/intel/openvino_2021 ]; then
        echo -e "\e[1;32mopenvino_2021 is installed\e[0m"
        ln -s  /opt/intel/openvino_2021/inference_engine/samples/ .
        echo -e "\e[1;31mOpenVino Samples Symbolic link created\e[0m"
        echo -e "\e[1;32m\nFollow the README.md in the respective folders for usage\e[0m"
else
        echo -e "\e[1;32mopenvino is not installed,kindly install openvino\e[0m"
fi



