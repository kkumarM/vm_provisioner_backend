#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ $(which rke2) && $(sudo rke2 --version) ]]; then
         echo "rke2 is installed, starting rke2 cluster"
         echo
         sudo systemctl enable rke2-server.service
         sudo systemctl start rke2-server.service
     else
         echo "install rke2 using install.sh file"

fi


