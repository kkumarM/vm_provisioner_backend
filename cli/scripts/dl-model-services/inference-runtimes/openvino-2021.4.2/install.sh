#!/bin/bash

if [[ $(sudo pip3 show openvino-dev) ]]; then
         echo -e "\e[1;32mopenvino-dev is installed\e[0m"
     else
         echo -e "\e[1;32mInstalling openvino-dev to download the models\e[0m"
         sudo pip3 install openvino-dev==2021.4.2
	 echo -e "\eopenvino 2021.4.2 installed successfully\e[0m"
fi
echo -e "\e[1;31mFor further queries please follow below URL\e[0m"
echo -e "\e[1;32m\nhttps://www.intel.com/content/www/us/en/developer/tools/openvino-toolkit/download.html\e[0m"

