#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ $(sudo pip3 show modin) ]]; then
         sudo pip3 uninstall modin[all] -y
         echo -e "\e[1;32m***********modin uninstalled successfully*********\e[0m"
fi

