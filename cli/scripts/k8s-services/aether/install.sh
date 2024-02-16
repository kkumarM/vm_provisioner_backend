#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

export HOST_IP=$(hostname -I | cut -d' ' -f1)

if [[ $(which curl) ]]; then
         echo "curl is installed"
     else
         sudo apt-get install curl
fi

#installation of Aiab
sudo ufw allow 31194
sudo ufw allow 31194/tcp
git config --global http.sslverify false
echo "Cloning Aether-in-a-box"
cd; git clone "https://gerrit.opencord.org/aether-in-a-box"
mkdir -p ~/cord
cd ~/cord
echo "Installing AiaB from local Helm Charts"
git clone "https://gerrit.opencord.org/sdcore-helm-charts"
git clone "https://gerrit.opencord.org/roc-helm-charts"
cd ~/aether-in-a-box
sudo cp /etc/environment /etc/default/rke2-server
sudo cp /etc/environment /etc/default/rke2-agent
echo "Installing Aether-In-a-Box with RKE2"
make roc-5g-models
helm -n aether-roc upgrade aether-roc-umbrella aether/aether-roc-umbrella
echo -e "\e[1;33mAether-In-a-Box is successfully installed and dashboard can be accessed from http://"$HOST_IP":31194\e[0m"
