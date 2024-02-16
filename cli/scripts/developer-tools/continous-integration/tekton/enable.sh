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

#starting minikube along kubernetes dashboard
minikube start --driver=docker
export NO_PROXY=$no_proxy,$(minikube ip)
echo -e "\e[1;32mminikube started\e[0m"

#installing tekon-pipelines
if [ $(kubectl get pods --namespace tekton-pipeline) ]; then
         echo -e "\e[1;36mtekton-pipeline is installed and running.......\e[0m"
     else
         echo -e "\e[1;36mInstalling tekton-pipeline..............\e[0m"
         kubectl apply --filename \
         https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
         echo -e "\e[1;32mInstalled tekton-pipelines successfully\e[0m"
         echo -e "\e[1;32m*****************************************************************\e[0m"
         echo -e "\e[1;33mkindly refer below link for reference on building tekton-pipeline:\e[0m"
         echo -e "\e[1;33mhttps://tekton.dev/\e[0m"
fi
