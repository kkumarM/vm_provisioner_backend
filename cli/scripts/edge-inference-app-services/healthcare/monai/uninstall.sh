#!/bin/bash

#uninstalling monai

echo -e "\e[1;32m\nninstaling monai\e[0m"

pip uninstall monai

#Deleting Cloned Repo

echo -e "\e[1;34m\nDeleting cloned Repo\e[0m"

DIR="MONAI"
if [ -d "$DIR" ]; then
   # Take action if $DIR exists. #
   echo -e "\e[1;36m\nDeleting cloned directory\e[0m"
   sudo rm -rf MONAI
else
   echo "Git repository does not exist to Delete"
fi
