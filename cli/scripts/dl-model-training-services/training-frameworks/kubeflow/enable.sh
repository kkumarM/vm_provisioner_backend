#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#enable services
echo -e "\e[1;32m******enabling the service********\e[0m"
microk8s enable dns storage ingress metallb:10.64.140.43-10.64.140.49
microk8s status --wait-ready

echo -e "\e[1;32mAll services enabled successfully and MicroK8s is Running.\e[0m"

#install juju

if [[ $(which juju) && $(sudo juju version) ]]; then
         echo "juju is installed"
     else
         echo "installing juju....."
         sudo snap install juju --classic
fi
echo -e "\e[1;32mCreate juju-controller\e[0m"
juju bootstrap microk8s
juju add-model kubeflow
echo -e "\e[1;32mDeploying kubeflow....\e[0m"
echo -e "\e[1;32mThis process can take several minutes\e[0m"
juju deploy kubeflow-lite --trust
juju config dex-auth public-url=http://10.64.140.43.nip.io
juju config oidc-gatekeeper public-url=http://10.64.140.43.nip.io
echo -e "\e[1;32mkubeflow deployed successfully\e[0m"
echo -e "\e[1;32mSetting up username and password\e[0m"
#read -p 'Username: ' uservar
#read -sp 'Password: ' passvar
juju config dex-auth static-username=admin
juju config dex-auth static-password=admin
echo -e "\e[1;32mAccess kubeflow Dashboard : http://10.64.140.43.nip.io\e[0m"
echo -e "\e[1;32mdex login credentials\e[0m"
echo -e "\e[1;32musername : admin\e[0m"
echo -e "\e[1;32mpassword : admin\e[0m"

