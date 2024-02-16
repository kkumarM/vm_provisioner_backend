#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking kubernetes is installed or not
echo "Checking Kuberentes is installed or not"

if [[ $(which kubectl) && $(kubectl version) ]]; then
         echo "Kubernetes is installed"

	 echo "Creating Namespace monitoring"
	 
	 kubectl create namespace monitoring
	 
	 echo "checking the namespace"
	 
	 kubectl get namespace
	 
         ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')

       	 echo "Creating prometheus and grafana"
	 
	 kubectl create -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/cluster-telemetry/.
         
         echo "Checking cluster-telemetry  pods"

	 kubectl get pods -n monitoring
     else
         echo "Install Kubernetes from devtool"
fi


echo "If Cluster-Telemetry is working fine.Then check metrics by using Grafana"
export HOST_IP=$(hostname -I | cut -d' ' -f1)
echo -e "\e[1;32m\n********* Grafana URL **************\e[0m"
echo -e "\e[1;36mGrafana Dashboard is available in the below URL\e[0m"
echo -e "\e[1;33mhttp://$HOST_IP:32400\e[0m\n"
