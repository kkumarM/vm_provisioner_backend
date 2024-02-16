#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

DIR="edgeapps"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo -e "\e[1;33mDeleting the cloned repository...\e[0m"
  echo "intel123" | sudo -S rm -rf $DIR
  if ! [[ -d "$DIR" ]]; then
	  echo -e "\e[1;32mRepository removed sucessfully\e[0m"
  fi
else
  echo -e "\e[1;31mRepository does not exist\e[0m"
fi

