#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#checking docker installed in the system
if [[ $(which docker) && $(docker --version) ]]; then
         echo -e "\e[1;32mDockerce is present in the system\e[0m"
     else
         echo -e "\e[1;32mInstall docker from devtool\e[0m"
fi

#pulling the modelserver image
sudo docker pull openvino/model_server:latest
echo -e "\e[1;32mopenvino-modelserver image pulled\e[0m"
echo -e "\e[1;31mFor further queries please follow below URL\e[0m"
echo -e "\e[1;32m\nhttps://github.com/openvinotoolkit/model_server\e[0m"

