#!/bin/bash

#uninstalling openfl
echo -e "\e[1;32m\nuninstaling openfl\e[0m"

pip uninstall openfl

#Deleting Cloned Repo

echo -e "\e[1;36m\nDeleting cloned Repo\e[0m"

DIR="openfl"
if [ -d "$DIR" ]; then
   # Take action if $DIR exists. #
   echo -e "\e[1;34m\nDeleting cloned directory\e[0m"
   sudo rm -rf openfl
else
   echo "Git repository does not exist to Delete"
fi
