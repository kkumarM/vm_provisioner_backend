#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ $(sudo docker ps -q -f name=workbench) || $(sudo docker ps -aq -f status=exited -f name=workbench) ]];then
       sudo docker rm -f  workbench
       echo -e "\e[1;32mWorkbench stopped\e[0m"
fi

