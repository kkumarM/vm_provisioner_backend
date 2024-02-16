#!/bin/bash
  
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#minikube stop
minikube delete --all
sudo rm -rf minikube-linux-amd64
sudo rm -rf  /usr/local/bin/kubectl
sudo rm -rf  /usr/local/bin/minikube
echo -e "\e[1;32m********************************************************* \e[0m"
echo -e "\e[1;32mminikube,kubectl and Argocd is removed completely \e[0m"

