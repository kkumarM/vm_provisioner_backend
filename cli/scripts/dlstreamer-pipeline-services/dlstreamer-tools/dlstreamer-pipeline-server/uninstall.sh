#!/bin/bash
USER=/home/intel

cd $USER
sudo docker rmi dlstreamer-pipeline-server-gstreamer
sudo rm -rf pipeline-server 
echo -e "\e[1;32mSuccessfully uninstalled\e[0m"
