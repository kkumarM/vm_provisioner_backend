#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

DIR="edgeapps"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo -e "\e[1;33mdeleting the cloned repository\e[0m"
  sudo rm -rf $DIR
  if ! [[ -d "$DIR" ]]; then
          echo -e "\e[1;32mRepository removed sucessfully\e[0m"
  fi
else
  echo -e "\e[1;33mRepository does not exist to delete\e[0m"
fi

