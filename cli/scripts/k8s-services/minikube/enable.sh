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

#starting the minikube dashboard
timeout 5s minikube dashboard

echo -e "\e[1;32mminikube dashboard can be accessed using:\e[0m"
echo -e "\e[1;35mhttp://$HOST_IP:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/\e[0m"
#enabling proxy
nohup kubectl proxy --address="0.0.0.0" --disable-filter=true & >/dev/null &
sleep 10s



