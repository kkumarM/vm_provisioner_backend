#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo "stopping K3s......"
sudo /usr/local/bin/k3s-killall.sh
echo "k3s services successfully stopped"
