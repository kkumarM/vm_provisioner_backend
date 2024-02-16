#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo $1
if [ "$(echo "intel123" | sudo docker ps -q -f name=^loki$)" ]; then
    echo -e "\e[1;32mStoping and Deleting Log-Analytics service\e[0m"
    export HOST_IP=$(hostname -I | cut -d' ' -f1)
    if [ $1=="all-services" ]; then
	ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')
        sudo -E docker-compose -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/log-analytics/docker-compose-app-service.yaml stop loki grafana promtail
	#sudo docker rm -f $(sudo docker ps -aq)
	sudo docker ps -a
    else
        ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')
        sudo -E docker-compose -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/log-analytics/docker-compose-app-service.yaml stop $1
	sudo docker ps -a
    fi
else
    echo "Log-Analytics is not running"
    echo -e "To start run command: '\e[1;3;4;33mdc app-services log-analytics start $1\e[0m'"
fi

