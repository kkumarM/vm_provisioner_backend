#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo "stopping RKE2......"
sudo /usr/local/bin/rke2-killall.sh
echo "RKE2 services successfully stopped"

