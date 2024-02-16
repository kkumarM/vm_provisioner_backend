#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Creating a symbolic link 

FILE=/home/intel/Public/dl-model-benchmark
echo $FILE
if [ ! -d "$FILE" ]; then
        echo -e "\e[1;31mdl-model-benchmark folder doesn't exists\e[0m"
else

        echo "intel123" | mv $FILE .
	sudo pip3 install py-cpuinfo numpy progress opencv-python
        source /opt/intel/openvino_2021/bin/setupvars.sh

        echo -e "\e[1;34mDl-model-benchmark files are present in workload folder\e[0m"        
        echo -e "\e[1;32m\nFollow the README.md in the respective folders for usage\e[0m"

fi

