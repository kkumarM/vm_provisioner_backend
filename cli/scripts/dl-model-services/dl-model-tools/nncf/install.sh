#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#!/bin/bash

# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


if [[ $(which git) && $(git --version) ]]; then
         echo -e "\e[1;36mgit installed in the system\e[0m"
     else
         echo -e "\e[1;36mInstalling git....\e[0m"
         sudo apt-get install git -y
fi

if !(git clone https://github.com/openvinotoolkit/nncf.git); then
        exit 1
        echo -e "\e[1;31mgit is failing check with version or with the git link\e[0m"
  else
    echo -e "\e[1;32mInstalling nncf...........\e[0m"
    cd nncf
    sudo python3 setup.py install
    echo -e "\e[1;32mnccf installed successfully under nncf folder\e[0m"
    echo -e "\e[1;32m\n*************************************************************************\e[0m"
    echo -e "\e[1;33mTo optimize a model from PyTorch, install PyTorch with the below command inside nncf folder:\e[0m"
    echo -e "\e[1;34mCommand:sudo python3 setup.py install --torch\e[0m"
    echo -e "\e[1;32m\n**************************************************************************\e[0m"
    echo -e "\e[1;33mTo optimize a model from TensorFlow,install TensorFlow with below command inside nncf folder:\e[0m"
    echo -e "\e[1;34mCommand:python setup.py install --tf\e[0m"
    echo -e "\e[1;32m\n***************************************************************************\e[0m"
    echo -e "\e[1;35mRefer below link for reference:\e[0m"
    echo -e "\e[1;33mhttps://github.com/openvinotoolkit/nncf\e[0m"
  fi
