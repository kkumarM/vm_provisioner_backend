#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo "Uninstalling K3s"
sudo /usr/local/bin/k3s-uninstall.sh
sudo rm -rf /var/lib/rancher
echo "k3s completely removed"

