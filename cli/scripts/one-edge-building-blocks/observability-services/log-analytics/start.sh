#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


sudo pip3 install docker
ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')
echo "-------------------------------------------------------"
sudo nohup python3 /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/log-analytics/generate_logs.py > nohup_log.txt &
echo -e "\e[1;36mLog Services are up..\e[0m"

echo $1
if [ "$(echo "intel123" | sudo docker ps -q -f name=^loki$)" ]; then
    echo -e "\e[1;32m\nLog-Analytics already running\e[0m"
    export HOST_IP=$(hostname -I | cut -d' ' -f1)
    echo -e "\e[1;32m\nPlease run the below command by entering into dc_cli\e[0m"
    echo -e "To stop run command: '\e[1;3;4;33mdc app-services log-analytics stop\e[0m'"
else
    echo -e "\e[1;32m\nInstalling Log-Analytics service\e[0m"
    export HOST_IP=$(hostname -I | cut -d' ' -f1)
    if [ $1=="all-services" ]; then
        sudo -E docker-compose -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/log-analytics/docker-compose-app-service.yaml  up -d --build loki promtail grafana
        sudo docker ps
    fi
fi

echo -e "\e[1;31m\nIf Log-Analytics is working fine.Then check metrics by using Grafana\e[0m"

export HOST_IP=$(hostname -I | cut -d' ' -f1)
echo -e "\e[1;32m\n********* Grafana URL **************\e[0m"
echo -e "\e[1;36mGrafana Dashboard is available in the below URL\e[0m"
echo -e "\e[1;33mhttp://$HOST_IP:3214\e[0m\n"


