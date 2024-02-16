#!/bin/bash
  
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


#checking wget
if [[ $(which wget) && $(wget --version) ]]; then
         echo -e "\e[1;36mwget installed in the system\e[0m"
     else
         echo -e "\e[1;36mInstalling wget....\e[0m"
         sudo apt install wget -y
fi

#installing head-pose-face-detection-male
if !(wget --cut-dirs=5 --no-parent https://github.com/intel-iot-devkit/sample-videos/blob/master/head-pose-face-detection-male.mp4) then
   exit 1
   echo -e"\e[1;32mwget is failing check with version or with the git link\e[0m"
else
    echo -e "\e[1;32m*****************************************************************\e[0m"
    echo -e "\e[1;32m'head-pose-face-detection-male' video downloaded successfully\e[0m"
fi
echo -e "\e[1;32m**********************************************************************\e[0m"
echo -e "\e[1;34mFor reference kindly use below url:\e[0m"
echo -e "\e[1;32mhttps://github.com/intel-iot-devkit/sample-videos/blob/master/head-pose-face-detection-male.mp4\e[0m"
