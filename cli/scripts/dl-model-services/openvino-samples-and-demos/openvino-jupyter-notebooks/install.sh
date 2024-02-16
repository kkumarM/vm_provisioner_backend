#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


echo -e "\e[1;32m********Installing jupyter notebook********\e[0m"
export HOST_IP=$(hostname -I | cut -d' ' -f1)
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-venv build-essential python3-dev git-all -y
sudo python3 -m venv openvino_env
source openvino_env/bin/activate
git clone --depth=1 https://github.com/openvinotoolkit/openvino_notebooks.git
cd openvino_notebooks
sudo apt install python3-testresources
sudo python3 -m pip install --upgrade pip wheel setuptools
sudo pip3 install -r requirements.txt
sudo apt install jupyter-notebook

echo -e "\e[1;32m*************Installed jupter-notebook successfully************\e[0m"
echo -e "\e[1;34mjupyter-notebook can be accessed using below link:\e[0m"
echo -e "\e[1;34m\nhttp://$HOST_IP:8888/\e[0m"

nohup jupyter notebook --no-browser --ip="$HOST_IP" & >/dev/null &
sleep 5s

