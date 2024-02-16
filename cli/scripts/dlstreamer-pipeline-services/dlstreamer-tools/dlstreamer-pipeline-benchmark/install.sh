#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Creating a symbolic link 

FILE=/home/intel/Public/dl_streamer_benchmark
echo ${PWD}
if [ ! -d "$FILE" ]; then
        echo -e "\e[1;31mdlstreamer-benchmark folder doesn't exists\e[0m"
else

        echo "intel123" | mv $FILE .
        sudo pip3 install numpy==1.19.3 opencv-python==4.5.*
        source /opt/intel/openvino_2021/bin/setupvars.sh


        echo -e "\e[1;34mdl-streamer-benchmark files are present\e[0m"        
              
        echo -e "\e[1;32m\nFollow the README.md in the respective folders for usage\e[0m"
fi

