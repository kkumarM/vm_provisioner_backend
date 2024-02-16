#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Stoping and Deleting Edgex 

echo "Stoping Edgex Containers"

docker-compose down

#Deleting docker-compose .yml file

sudo rm -rf docker-compose.yml
