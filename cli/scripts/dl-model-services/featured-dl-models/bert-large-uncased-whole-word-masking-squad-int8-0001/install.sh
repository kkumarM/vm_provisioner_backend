#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#checking openvino installation

if [[ $(sudo pip3 show openvino-dev) ]]; then
         echo -e "\e[1;32mopenvino-dev is installed\e[0m"
     else
         echo -e "\eInstalling openvino-dev to download the models\e[0m"
         sudo  pip3 install openvino-dev==2021.4.2
	 sudo -H pip3 install --ignore-installed PyYAML
fi

#downloading the model
omz_downloader --name bert-large-uncased-whole-word-masking-squad-int8-0001
echo -e "\e[1;32mmodel is downloaded under the intel folder\e[0m"

echo -e "\e[1;31mFor further queries please follow below URL\e[0m"

echo -e "\e[1;32m\nhttps://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/bert-large-uncased-whole-word-masking-squad-int8-0001\e[0m"

