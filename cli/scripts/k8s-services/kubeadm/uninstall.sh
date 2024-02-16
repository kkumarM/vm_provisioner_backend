#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

sudo kubeadm reset -f
sudo apt purge kubectl kubeadm kubelet kubernetes-cni -y --allow-change-held-packages
sudo apt autoremove
echo "deleting required kubernetes files"
sudo rm -fr /etc/kubernetes/; sudo rm -fr ~/.kube/; sudo rm -fr /var/lib/etcd; sudo rm -rf /var/lib/cni/

sudo systemctl daemon-reload
echo "clearing iptables"
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

echo "removing all running docker containers"
docker rm -f `docker ps -a | grep "k8s_" | awk '{print $1}'`
echo -e "\e[1;33mkubeadm is successfully uninstalled\e[0m"
