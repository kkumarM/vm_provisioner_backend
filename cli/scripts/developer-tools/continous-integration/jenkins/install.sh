#!/bin/bash
  
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

export HOST_IP=$(hostname -I | cut -d' ' -f1)

#checking the jdk
if [[ $(which java) && $(java -version) ]]; then
        echo -e "\e[1;36mjdk is already present in the system\e[0m"
else
        echo -e "\e[1;33mInstalling jdk....\e[0m"
        sudo apt-get update -y
        sudo apt install default-jre
fi

#checking the javac
if [[ $(which javac) && $(javac -version)  ]]; then
        echo -e "\e[1;36mjdk is already present in the system\e[0m"
else
        echo -e "\e[1;33mInstalling jdk....\e[0m"
        sudo apt-get update -y
        javac -version
fi

#checking wget
if [[ $(which wget) && $(wget --version) ]]; then
         echo -e "\e[1;36mwget installed in the system\e[0m"
     else
         echo -e "\e[1;36mInstalling wget....\e[0m"
         sudo apt install wget -y
fi

#installing jenkins
if [[ $(jenkins --version) ]]; then
        echo -e "\e[1;32m\njenkins is already installed in the system\e[0m"
        echo -e "\e[1;32m******************************************\e[0m"
        echo -e "\e[1;34mTo check the status of jenkins:\e[0m"
        echo -e "\e[1;33mCommand:'sudo systemctl status jenkins'\e[0m"
    else
        echo -e  "\e[1;32m*************************************\e[0m"
        echo -e  "\e[1;32mInstalling Jenkins..................\e[0m"
        wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg -y
        sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
        sudo apt update
        sudo apt install jenkins
        sudo ex +g/useSecurity/d +g/authorizationStrategy/d -scwq /var/lib/jenkins/config.xml
        sudo systemctl start jenkins.service
        sudo ufw allow 8080
        sudo ufw allow OpenSSH
        echo "y" | sudo ufw enable
        echo -e "\e[1;32m\njenkins installed and started successfully\e[0m"
        echo -e "\e[1;32m*******************************************\e[0m"
        echo -e "\e[1;34mjenkins can be accessed with the below url and make the initial setup:\e[0m"
        echo -e "\e[1;33m\nhttp://$HOST_IP:8080\e[0m"
fi

echo -e "\e[1;35m\nRefer the below link for jenkins documentation\e[0m"
echo -e "\e[1;35mhttps://www.jenkins.io/\e[0m"

