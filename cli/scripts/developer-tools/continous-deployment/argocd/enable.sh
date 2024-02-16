#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

export HOST_IP=$(hostname -I | cut -d' ' -f1)
if [[ $(which minikube) && $(minikube version) ]]; then
         echo -e "\e[1;36mminikube is installed, starting minikube\e[0m"
     else
         echo -e "\e[1;36mInstall minikube using install-minikube.sh file\e[0m"
         echo
fi

export NO_PROXY=$no_proxy,$(minikube ip)

#starting minikube along kubernetes dashboard
minikube start --driver=docker
export NO_PROXY=$no_proxy,$(minikube ip)
echo -e "\e[1;32mminikube started\e[0m"

if [ $(kubectl get pods --namespace argocd) ]; then
         echo -e "\e[1;36margocd is installed and running.......\e[0m"
     else
         echo -e "\e[1;36mInstalling argocd..............\e[0m"
         kubectl create namespace argocd
         kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/core-install.yaml
         echo -e "\e[1;32mInstalled argocd successfully\e[0m"
         echo -e "\e[1;32m*****************************************************************\e[0m"
         echo -e "\e[1;33mkindly refer below link for reference on running argocd:\e[0m"
         echo -e "\e[1;33mhttps://github.com/argoproj/argo-cd\e[0m"
fi

