#!/bin/bash
  
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ $(which git) && $(git --version) ]]; then
         echo -e "\e[1;36mgit installed in the system\e[0m"
     else
         echo -e "\e[1;36mInstalling git....\e[0m"
         sudo apt-get install git -y
fi

echo -e "\e[1;32mInstalling predictive health analytics...........\e[0m"
if !(git clone https://github.com/oneapi-src/predictive-health-analytics.git); then
        exit 1
        echo -e "\e[1;31mgit is failing check with version or with the git link\e[0m"
  else
    echo -e "\e[1;32mInstalled successfully under 'predictive-health-analytics' folder\e[0m"
    echo -e "\e[1;32m*************************************************************************\e[0m"
    echo -e "\e[1;35mRefer below link for reference:\e[0m"
    echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-kit/predict-utility-asset-health.html\e[0m"
  fi
