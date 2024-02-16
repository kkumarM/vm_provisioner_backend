#!/bin/bash

USER=/home/intel

cd $USER
DIR=$PWD/pipeline-zoo
MODEL_PATH=$PWD

if [[ $(which docker) && $(docker --version) ]]; then
      echo -e "\e[1;33mDocker is present in the system\e[0m"
else
        echo -e "\e[1;31mPlease install Docker, DockerCE, and Docker compose\e[0m"
        exit 0
fi

if [ -d "$DIR" ]; then
	echo "Success"
else
    git clone https://github.com/dlstreamer/pipeline-zoo.git pipeline-zoo
fi
cd pipeline-zoo/tools/docker/
sudo ./build.sh 
echo -e "\e[1;32mSuccessfully installed\e[0m"
echo -e "\e[1;31mFor further queries please follow below URL\e[0m"
echo -e "\e[1;32m\nhttps://github.com/dlstreamer/pipeline-zoo\e[0m"


