#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ $(sudo pip3 show scikit-learn ) ]]; then
	 sudo pip3 uninstall scikit-learn -y
         echo -e "\e[1;32m***********scikit-learn uninstalled successfully*********\e[0m"
fi

