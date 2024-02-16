#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#checking helm in the system

export HOST=hostname+".intel.com"

if [[ $(which helm) && $(helm version) ]]; then
         echo -e "\e[1;36mHelm is already present in the system\e[0m"
     else
         curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
         chmod 700 get_helm.sh
         ./get_helm.sh
         echo -e "\e[1;36mInstallation of helm is successfully\e[0m"
fi

#install cnvrg
if [[ $(which cnvrg) && $(cnvrg --version) ]]; then
         echo -e "\e[1;32mcnvrg is installed\e[0m"
     else
         echo -e "\e[1;32minstalling cnvrg.....\e[0m"
         sudo apt-get update
         echo "Installing ruby"
         sudo apt-get install -y ruby ruby-dev libxslt-dev libxml2-dev zlib1g-dev shared-mime-info
         sudo gem install cnvrg --no-document
	 helm repo add cnvrgv3 https://charts.v3.cnvrg.io
         helm repo update 
         helm search repo cnvrgv3/cnvrg -l
         helm install cnvrg cnvrgv3/cnvrg --create-namespace -n cnvrg --timeout 1500s \
	 --set clusterDomain=${HOST} \
	 --set controlPlane.webapp.enabled=false \
	 --set controlPlane.sidekiq.enabled=false \
	 --set controlPlane.searchkiq.enabled=false \
 	 --set controlPlane.systemkiq.enabled=false \
	 --set controlPlane.hyper.enabled=false \
	 --set logging.elastalert.enabled=false \
	 --set dbs.minio.enabled=false
         echo -e "\e[1;32mcnvrg installed successfully\e[0m"
fi
