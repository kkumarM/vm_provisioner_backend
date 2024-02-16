#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo $
if [ "$(echo "intel123" | sudo docker ps -q -f name=^system_influxdb$)" ]; then
    echo -e "\e[1;32m\nSystem-Telemetry already running\e[0m"
    echo -e "\e[1;32m\nPlease run the below command by entering into dc_cli\e[0m"
    echo -e "To stop run command: '\e[1;3;4;33mdc app-services system-telemetry stop $1\e[0m'"
else
    echo -e "\e[1;32m\nInstalling System-Telemetry service\e[0m"
    export HOST_IP=$(hostname -I | cut -d' ' -f1)
    ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')
    if [ $1=="all-services" ]; then      
        sudo -E docker-compose -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/system-telemetry/docker-compose-app-service.yaml  up -d --build influxdb grafana collectd    
        sudo docker ps
    fi
fi



echo "If System-Telemetry is working fine.Then check metrics by using Grafana"
export HOST_IP=$(hostname -I | cut -d' ' -f1)
echo -e "\e[1;32m\n********* Grafana URL **************\e[0m"
echo -e "\e[1;36mGrafana Dashboard is available in the below URL\e[0m"
echo -e "\e[1;33mhttp://$HOST_IP:3211\e[0m\n"
