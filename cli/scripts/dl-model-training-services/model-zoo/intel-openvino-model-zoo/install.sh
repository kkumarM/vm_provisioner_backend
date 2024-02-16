#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#installing omz-tool
if [ -d /opt/intel/openvino_2021 ]; then
        echo -e "\e[1;32mopenvino_2021 is installed\e[0m"
        source /opt/intel/openvino_2021/bin/setupvars.sh
        ln -s /opt/intel/openvino_2021/deployment_tools/tools/ .
        echo -e "\e[1;31mOpenvino-model-zoo Symbolic link created\e[0m"
        echo -e "\e[1;32m\nFollow the README.md for usage\e[0m"
else
        echo -e "\e[1;32mopenvino is not installed,kindly install openvino\e[0m"
fi


