#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo $1
if [ "$(echo "intel123" | sudo docker ps -q -f name=$1)" ]; then
    echo "Restarting $1 service"
    export HOST_IP=$(hostname -I | cut -d' ' -f1)
    if [ $1=="all-services" ]; then
        ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')
        sudo -E docker-compose -f /usr/local/lib/python$ver/dist-packages/src/scripts/app-services/cluster-telemetry/docker-compose-app-service.yaml restart $1
         grafana prometheus node-exporter
    fi
fi


