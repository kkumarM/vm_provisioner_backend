#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the git is present or not
if [[ $(which git) && $(git --version) ]]; then
        echo -e "\e[1;32mGit is already installed in the system\e[0m"
else
        echo -e "\e[1;31mGit is not installed\e[0m"
        sudo apt-get update
        sudo apt-get install git
fi


#cloning the git repo
DIR="edgeapps"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo -e "\e[1;32mRepository already present\e[0m"
else
  echo -e "\e[1;36mCloning the git repository\e[0m"
  git clone https://github.com/smart-edge-open/edgeapps.git
  success=$?
  if [[ $success -eq 0 ]];then
    echo -e "\e[1;32mRepository successfully cloned..\e[0m"
    echo -e "\e[1;36mPlease navigate to edgeapps/applications/orbo-AI-image-enhancement\e[0m"
  else
    echo -e "\e[1;33mUnable to clone the repository\e[0m"
  fi
fi
