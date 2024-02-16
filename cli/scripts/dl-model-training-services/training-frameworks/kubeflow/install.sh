#!/bin/sh

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ $(which docker) && $(docker --version) ]]; then
        echo -e "\e[1;36mDockerce is present in the system\e[0m"
     else
         echo -e "\e[1;36mInstall docker from devtool\e[0m"
fi

#install microk8s
if [[ $(which microk8s) && $(sudo microk8s ctr version) ]]; then
         echo -e "\e[1;32mMicrok8s is installed\e[0m"
     else
         echo -e "\e[1;32m*******installing microk8s*******\e[0m"
         echo
         sudo apt install snapd 
         sudo snap install microk8s --classic --channel=1.21
         sudo usermod -a -G microk8s $USER
         sudo chown -f -R $USER ~/.kube
         echo "intel123" | sudo -S sleep 1 && sudo su $USER

         #sudo ufw allow in on cni0 && sudo ufw allow out on cni0
         #sudo ufw default allow routed
fi

echo "To deploy the kubeflow run the enable.sh "

