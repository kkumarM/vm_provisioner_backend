#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0
sudo apt-get update
sudo apt-get install expect -y
echo -e "\e[1;33mInstalling Chrome ...\e[0m"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
export HOST_IP=$(hostname -I | cut -d' ' -f1)
sudo docker pull openedgeinsights/ia_etcd_ui:2.6.1
sudo docker pull openedgeinsights/ia_video_analytics:2.6.1
sudo docker pull openedgeinsights/ia_video_ingestion:2.6.1
sudo docker pull openedgeinsights/ia_web_visualizer:2.6.1
sudo docker pull openedgeinsights/ia_etcd_provision:2.6.1
sudo docker pull openedgeinsights/ia_etcd:2.6.1
echo "Installing edgesoftware ..."
pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo $HOST_IP
/usr/bin/expect -c '
set timeout -1
spawn $::env(HOME)/.local/bin/edgesoftware install wireless-network-ready-pcb-defect-detection 62bbe94bfa82fa7cf96de6de
#expect "Please enter the Product Key. The Product Key is contained in the email you received from Intel confirming your download:" {send "c259ebe1-e326-46e3-b2fd-1f95e20476ad\n"}
expect "(Example:: 123.123.123.123):" {send $::env(HOST_IP)\n"}
expect EOF'

HOST_IP=$(hostname -I | cut -d' ' -f1)
echo -e "\e[1;32m\n********* To visualize the results, open Google* Chrome and navigate to the links below for respective results:  **************\e[0m"
echo -e "\e[1;33mWeb Visualizer\e[0m"
echo -e "\e[1;36mhttp://$HOST_IP:30009 -DEV Mode\e[0m"
echo -e "\e[1;33mEtcd UI\e[0m"
echo -e "\e[1;36mhttp://$HOST_IP:30010/etcdkeeper\e[0m"
echo -e "\e[1;32m******** To access the visualizer, log in with the username = admin and token = admin@123 *******\e[0m"
