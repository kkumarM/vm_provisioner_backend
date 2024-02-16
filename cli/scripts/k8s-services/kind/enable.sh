#!/bin/bash


# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ $(which kind) && $(sudo kind -- version) ]]; then
         echo -e "\e[1;32mkind is installed, starting kind single-node cluster\e[0m"
	 echo
	 kind create cluster
     else
         echo -e "\e[1;36minstall kind using install-kind.sh file\e[0m"
         
fi


