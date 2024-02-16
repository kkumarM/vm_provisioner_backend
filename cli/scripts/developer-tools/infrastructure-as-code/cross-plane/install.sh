#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#checking docker in the system
if [[ $(which docker) && $(docker --version) ]]; then
         echo -e "\e[1;36mDockerce is present in the system\e[0m"
     else
         echo -e "\e[1;36mInstall docker from devtool\e[0m"
fi

#install kind
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

if [[ $(which kind) && $(sudo kind -- version) ]]; then
         echo -e "\e[1;32mkind is installed, starting kind single-node cluster\e[0m"
         echo
         kind create cluster
     else
         echo -e "\e[1;36minstall kind using install-kind.sh file\e[0m"
fi

if [ $(which kubectl) ]; then
         echo -e "\e[1;32mkubectl is installed\e[0m"
     else
         echo -e "\e[1;36minstalling kubectl......\e[0m"
         sudo snap install kubectl --classic
         echo -e "\e[1;36mkubectl installed successfully\e[0m"
fi

if [ $(which helm) ]; then
         echo -e "\e[1;32mhelm is installed\e[0m"
     else
         echo -e "\e[1;36minstalling helm......\e[0m"
         sudo snap install helm --classic
         echo -e "\e[1;36mHelm installed successfully\e[0m"
fi

if [ $(kubectl get all -n crossplane-system) ]; then
         echo -e "\e[1;32mcrossplane is installed\e[0m"
     else
         echo -e "\e[1;36minstalling crosplane......\e[0m"
         kubectl create namespace crossplane-system
         helm repo add crossplane-stable https://charts.crossplane.io/stable
         helm repo update
         helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
         echo -e "\e[1;36mcrossplane installed successfully\e[0m"
fi

