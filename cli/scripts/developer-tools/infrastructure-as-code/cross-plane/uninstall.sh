#!/bin/bash
  
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

kind delete cluster
echo -e "\e[1;32mKind deleted\e[0m"
sudo snap remove kubectl
echo -e "\e[1;32mKubectl is uninstalled successfully\e[0m"
sudo snap remove helm
echo -e "\e[1;32mHelm uninstalled successfully\e[0m"
