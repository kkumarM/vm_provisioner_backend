#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#Checking OS_VERSION

echo "Checking OS_VERSION"

OS_VERSION=$( . /etc/os-release ; echo $VERSION_ID)
echo "System OS : $OS_VERSION"

if [[ $OS_VERSION != "20.04" ]]; then
        echo -e "\e[1;32mThe application only supports Ubuntu20 OS. Please select the specified OS for the application\e[0m\n"
        echo -e "\e[1;32mExiting the MarketPlace component installation.....\e[0m\n"
        exit 1

fi

#Installing interactive-kiosk-ai-chatbot

echo "Installing interactive-kiosk-ai-chatbot ..."

echo -e "\e[1;36m\nThis will take couple of minutes....\e[0m"
pip3 install --upgrade pip --user && pip3 install edgesoftware --user
echo 6b90d312-0969-45b6-be28-6f6ac8873d9e | $HOME/.local/bin/edgesoftware install interactive-kiosk-ai-chatbot 62443d3a9654a8f4bd9cbca6

echo -e "\e[1;34mInteractive-Kiosk-AI-Chatbot<version> folder is downloaded successfully in Workload folder\e[0m\n"

#Checking RI is installed sucessfully

echo -e "\e[1;32m\nIf interactive-kiosk-ai-chatbot RI installed successfully...\e[0m"
echo -e "\e[1;36mFor further development refer below URL\e[0m"
echo -e "\e[1;33mhttps://www.intel.com/content/www/us/en/developer/articles/reference-implementation/interactive-kiosk-ai-chatbot.html\e[0m\n"
