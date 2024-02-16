#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Installing Cluster-Telemetry
echo "Installing Cluster-Telemetry"

echo $
if [ "$(echo "intel123" | sudo docker ps -q -f name=^cluster_prometheus$)" ]; then
    echo -e "\e[1;32m\nCluster-Telemetry already running\e[0m"
    echo -e "\e[1;32m\nPlease run the below command by entering into dc_cli\e[0m"
    echo -e "To stop run command: '\e[1;3;4;33mdc app-services cluster-telemetry stop $1\e[0m'"
else
    echo -e "\e[1;32m\nInstalling Cluster-Telemetry service\e[0m"
    export HOST_IP=$(hostname -I | cut -d' ' -f1)
    ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')
    if [ $1=="all-services" ]; then      
         sudo -E docker-compose -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/cluster-telemetry/docker-compose-app-service.yaml  up -d --build grafana prometheus node-exporter    
         sudo docker ps 
    fi
fi

echo "If cluster-telemetry is working fine.Then check metrics by using Grafana"
export HOST_IP=$(hostname -I | cut -d' ' -f1)
echo -e "\e[1;32m\n********* Grafana URL **************\e[0m"
echo -e "\e[1;36mGrafana Dashboard is available in the below URL\e[0m"
echo -e "\e[1;33mhttp://$HOST_IP:3212\e[0m\n"
