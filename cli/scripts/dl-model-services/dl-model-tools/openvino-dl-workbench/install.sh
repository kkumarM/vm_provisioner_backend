#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo "checking for docker installation"
if [[ $(which docker) && $(docker --version) ]]; then
         echo -e "\e[1;32mDockerce is present in the system\e[0m"
     else
	 echo -e "\e[1;32mInstall docker from devtool\e[0m"
   fi

echo "checking for the pip installation"
if [[ $(which pip) && $(pip --version) ]]; then
         echo -e "\e[1;32mpip is installed in the system\e[0m"
     else
         echo -e "\e[1;32mInstall pip-package\e[0m"
	 sudo apt update
	 sudo apt install python3-pip -y
   fi

#python3 -m pip install -U openvino-workbench
sudo docker pull openvino/workbench:2021.4.2
echo -e "\e[1;32mWorkbench image is pulled successfully\e[0m"
echo -e "\e[1;35mTo view the images: docker images\e[0m"
echo -e "\e[1;31m\nRefer below URL to get started:\e[0m"
echo -e "\e[1;32mhttps://docs.openvino.ai/latest/workbench_docs_Workbench_DG_Install.html\e[0m"


