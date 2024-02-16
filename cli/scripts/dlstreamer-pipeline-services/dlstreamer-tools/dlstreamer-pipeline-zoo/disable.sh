#!/bin/bash
USER=/home/intel

cd $USER
sudo docker rmi media-analytics-pipeline-zoo
echo -e "\e[1;32mSuccessfully disabled\e[0m"
