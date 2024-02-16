#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#minikube stop
minikube delete --all
sudo rm -rf minikube-linux-amd64
sudo rm -rf  /usr/local/bin/kubectl
sudo rm -rf  /usr/local/bin/minikube
echo -e "\e[1;32mminikube and kubectl is removed \e[0m"

