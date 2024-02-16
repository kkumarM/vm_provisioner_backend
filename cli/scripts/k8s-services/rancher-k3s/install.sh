#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

export HOST_IP=$(hostname -I | cut -d' ' -f1)
ver=$(python3 --version | grep Python | awk '{print $2}' | xargs printf '%0.1f\n')

if [[ $(which docker) && $(docker --version) ]]; then
         echo "Docker is installed "
     else
         echo "Install docker from devtool"
         # command
         #sudo apt-get remove docker docker-engine docker.io containerd runc
fi

#install k3s
sudo ufw allow 30040
sudo ufw allow 30040/tcp

if [[ $(which k3s) && $(sudo k3s --version) ]]; then
         echo "k3s is installed"
     else
         echo "installing k3s....."
         
         curl -sfL https://get.k3s.io | sh -
         sudo groupadd docker
         sudo usermod -aG docker $USER
         GITHUB_URL=https://github.com/kubernetes/dashboard/releases
         VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
         sudo k3s kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
         echo "Creating dashboard user and assigning roles"
         sudo k3s kubectl create -f /usr/local/lib/python$ver/dist-packages/src/scripts/k8s-services/rancher-k3s/dashboard.admin-user.yml -f  /usr/local/lib/python$ver/dist-packages/src/scripts/k8s-services/rancher-k3s/dashboard.admin-user-role.yml
         sudo k3s kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
         sudo k3s kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard --type='json' -p '[{"op":"replace","path":"/spec/ports/0/nodePort","value":30040}]'
         sudo k3s kubectl -n kubernetes-dashboard create token admin-user
         sudo k3s kubectl get svc -n kubernetes-dashboard -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}'
         echo "ClusterIP replaced with NodePort"
         NODE_PORT=`sudo k3s kubectl get svc -n kubernetes-dashboard -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}'`
         echo -e "\e[1;36mIt will take couple of minutes for the K3s server to start up\e[0m"
         echo -e "\e[1;36mPlease use generated token to login into your dashboard\e[0m"
         echo -e "\e[1;33mInstalled K3s successfully, Control Plane can be accessed by clicking https://"$HOST_IP":"$NODE_PORT"\e[0m"

fi
