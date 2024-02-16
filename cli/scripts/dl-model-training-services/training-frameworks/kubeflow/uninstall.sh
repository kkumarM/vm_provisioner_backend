#!/bin/sh

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo -e "\e[1;32mDestroying juju-controller\e[0m"
juju kill-controller -y microk8s-localhost
echo -e "\e[1;32mjuju-controller destroyed\e[0m"
echo -e "\e[1;32mReset microk8s\e[0m"
echo -e "\e[1;32mwait few minutes....\e[0m"
microk8s reset
echo -e "\e[1;32mdisabling the services\e[0m"
microk8s.disable dashboard dns
echo -e "\e[1;32mremoving microk8s...\e[0m"
sudo snap remove microk8s
echo -e "\e[1;32microk8s removed\e[0m"
echo -e "\e[1;32mremoving juju...\e[0m"
sudo snap remove --purge  juju
rm -rf ~/.local/share/juju
echo -e "\e[1;32mUninstallation finished\e[0m"
