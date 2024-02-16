#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo $1
if [ "$(echo "intel123" | sudo docker ps -q -f name=^cluster_prometheus$)" ]; then
    echo -e "\e[1;32m\nStoping and Deleting Cluster-Telemetry service\e[0m"
    export HOST_IP=$(hostname -I | cut -d' ' -f1)
    if [ $1=="all-services" ]; then
        ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')  
        sudo -E docker-compose -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/cluster-telemetry/docker-compose-app-service.yaml stop grafana prometheus node-exporter
	#sudo docker rm -f $(sudo docker ps -aq)
	sudo docker ps 
    else
	ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')
        sudo -E docker-compose -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/cluster-telemetry/docker-compose-app-service.yaml stop $1
    fi
else
    echo "Cluster-Telemetry is not running"
    echo -e "To start run command: '\e[1;3;4;33mdc app-services cluster-telemetry start $1\e[0m'"
fi
