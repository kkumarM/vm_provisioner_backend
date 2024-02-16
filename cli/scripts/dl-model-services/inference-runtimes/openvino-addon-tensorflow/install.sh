#!/bin/bash


# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ $(sudo pip3 show pip) ]]; then
         echo -e "\e[1;32mpip is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling pip ....\e[0m"
         sudo pip3 install -U pip
fi

if [[ $(sudo pip3 show tensorflow) ]]; then
         echo -e "\e[1;32mtensorflow is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling tensorflow ....\e[0m"
         sudo pip3 install tensorflow==2.8.0
fi

if [[ $(sudo pip3 show openvino-tensorflow ) ]]; then
         echo -e "\e[1;32mopenvino-tensorflow is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling openvino-tensorflow ....\e[0m"
         sudo pip3 install openvino-tensorflow==2.0.0
	 echo -e "\e[1;32mInstalled openvino-tensorflow successfully\e[0m"
	 echo -e "\e[1;31mFor further queries please follow below URL\e[0m"
	 echo -e "\e[1;32m\nhttps://openvinotoolkit.github.io/openvino_tensorflow/\e[0m"
fi



