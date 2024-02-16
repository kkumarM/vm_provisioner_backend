#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo $
if [ "$(echo "intel123" | sudo docker ps -q -f name=^docker_cadvisor$)" ]; then
    echo -e "\e[1;32m\nDocker-Telemetry already running\e[0m"
    echo -e "\e[1;32m\nPlease run the below command by entering into dc_cli\e[0m"
    echo -e "To stop run command: '\e[1;3;4;33mdc app-services docker-telemetry stop  $1\e[0m'"
else
    echo -e "\e[1;32m\nInstalling Docker-Telemetry service\e[0m"
    export HOST_IP=$(hostname -I | cut -d' ' -f1)
    ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')
    if [ $1=="all-services" ]; then      
        sudo -E docker-compose -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/docker-telemetry/docker-compose-app-service.yaml  up -d --build grafana cadvisor prometheus   
        sudo docker ps	
    fi
fi


echo "If docker-telemetry is working fine.Then check metrics by using Grafana"
export HOST_IP=$(hostname -I | cut -d' ' -f1)
echo -e "\e[1;32m\n********* Grafana URL **************\e[0m"
echo -e "\e[1;36mGrafana Dashboard is available in the below URL\e[0m"
echo -e "\e[1;33mhttp://$HOST_IP:3213\e[0m\n"
