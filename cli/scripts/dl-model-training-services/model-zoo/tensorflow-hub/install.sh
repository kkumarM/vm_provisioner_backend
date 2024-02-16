# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


if [[ $(pip3 --version) ]]; then
         echo -e "\e[1;32mpip3 is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling pip3\e[0m"
         sudo apt-get update
         sudo apt-get -y install python3-pip
fi

#installing tensorflow-hub
if [[ $(pip3 show tensorflow_hub) ]]; then
         echo -e "\e[1;32mtensorflow_hub is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling tensorflow_hub repository of trained models\e[0m"
         sudo pip3 install tensorflow-cpu==2.9.1
         sudo pip3 install --upgrade tensorflow_hub
         echo -e "\e[1;32mTensorFlow Hub for trained machine learning model is installed\e[0m"
fi

echo -e "\e[1;33m*************Kindly refer the below link to get started with Tensorflow-hub************\e[0m"
echo -e "\e[1;34m\nhttps://tfhub.dev/\e[0m"
