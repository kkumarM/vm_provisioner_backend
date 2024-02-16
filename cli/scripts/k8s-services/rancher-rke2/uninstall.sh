#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo "Uninstalling RKE2"
sudo rm -rf /usr/local/bin/rke2-uninstall.sh
sudo rm -rf /var/lib/rancher
echo -e "\e[1;33mRKE2 completely removed\e[0m"


