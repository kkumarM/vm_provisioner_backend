#!/bin/bash
#Copyright (C) 2018-2021 Intel Corporation
#SPDX-License-Identifier: Apache-2.0

#Checking if the puppet is present in the system
if [[ $(which puppet) && $(puppet --version) ]]; then
        echo -e "\e[1;36mpuppet is already present in the system\e[0m"
else
        echo -e "\e[1;33mInstalling puppet.....This will take few mins...\e[0m"
        echo -e "\e[1;32mBefore starting installation update /etc/hosts file with puppetmaster ip and puppet client ip's..\e[0m" 
        sudo apt-get update -y
        sudo curl -O https://apt.puppetlabs.com/puppet7-release-bionic.deb
        sudo dpkg -i puppet7-release-bionic.deb
        sudo apt-get update -y
        sudo apt-get install puppetserver -y
        sudo systemctl enable puppetserver.service
        sudo systemctl start puppetserver.service
        sudo apt policy puppetserver
        sudo cp /opt/puppetlabs/bin/puppet /usr/bin/ -v
        sudo cp /opt/puppetlabs/puppet/bin/gem /usr/bin/ -v


        #Checking if the puppet is installed successfully
        if [[ $(which puppet) && $(puppet --version) ]]; then
                puppet_version=$(puppet --version)
                echo -e "\e[1;32mSuceessfully installed Puppet : $puppet_version \e[0m"
                echo -e "\e[1;33mAfter puppetserver installed successfully then run these commands on puppetclient servers\e[0m"
                echo -e "\e[1;36msudo curl -O https://apt.puppetlabs.com/puppet7-release-bionic.deb\e[0m"
                echo -e "\e[1;32msudo dpkg -i puppet7-release-bionic.deb\e[0m"
                echo -e "\e[1;33msudo apt-get update -y\e[0m"
                echo -e "\e[1;36msudo apt-get install puppet-agent -y\e[0m"
                echo -e "\e[1;32mAdd the following lines to the end of the Puppet configuration file to define the Puppet master information--->"sudo nano /etc/puppetlabs/puppet/puppet.conf"\e[0m"
                echo "[main]
                      certname = puppetclient
                      server = puppetmaster"
                echo -e "\e[1;36msudo systemctl start puppet\e[0m"
                echo -e "\e[1;33msudo systemctl enable puppet\e[0m"   
                echo -e "\e[1;32msudo /opt/puppetlabs/bin/puppetserver ca list --all\e[0m"
                echo -e "\e[1;36msudo /opt/puppetlabs/bin/puppetserver ca sign --all\e[0m"
                echo -e "\e[1;33msudo /opt/puppetlabs/bin/puppet agent --test\e[0m"     
        fi
fi
