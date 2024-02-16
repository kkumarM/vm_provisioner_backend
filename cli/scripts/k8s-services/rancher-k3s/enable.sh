#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


if [[ $(which k3s) && $(sudo k3s --version) ]]; then
         echo "k3s is installed, starting k3s cluster"
         echo
         sudo systemctl start k3s
     else
         echo "install k3s using install.sh file"

fi

