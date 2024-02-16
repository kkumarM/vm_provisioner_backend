#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#checking docker in the system
if [[ $(which docker) && $(docker --version) ]]; then
	 echo -e "\e[1;36mDockerce is present in the system\e[0m"
     else
         echo -e "\e[1;36mInstall docker from devtool\e[0m"
fi

#install microk8s
if [[ $(which kind) && $(sudo kind --version) ]]; then
         echo -e "\e[1;32mkind is installed\e[0m"
     else
         echo -e "\e[1;32minstalling kind.....\e[0m"
         echo
         curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.12.0/kind-linux-amd64
         sudo chmod +x ./kind
	 sudo groupadd docker
         sudo usermod -aG docker $USER
         sudo mv ./kind /usr/local/bin/kind
	 echo -e "\e[1;32mkind installed\e[0m"
fi

