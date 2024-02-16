#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#checking wget
if [[ $(which wget) && $(wget --version) ]]; then
         echo -e "\e[1;36mwget installed in the system\e[0m"
     else
         echo -e "\e[1;36mInstalling wget....\e[0m"
         sudo apt install wget -y
fi

#installing ai-models

if (wget -r -nH --cut-dirs=4 --no-parent https://github.com/IntelAI/models/tree/master/models); then
        exit 1
        echo -e"\e[1;32mwget is failing check with version or with the git link\e[0m"
  else
        echo -e "\e[1;32msuccess\e[0m"
        echo -e "\e[1;32mSuccessfully downloaded the AI-models under the folder 'models'\e[0m"
fi

echo -e "\e[1;31m\nFollow below URL for the reference:\e[0m"
echo -e "\e[1;32mhttps://github.com/IntelAI/models/tree/master/models\e[0m"


