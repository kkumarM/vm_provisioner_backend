#!/bin/bash

if [[ $(which docker) && $(docker --version) ]]; then
      echo -e "\e[1;33mDocker is present in the system\e[0m"
else
	echo -e "\e[1;31mPlease install Docker, DockerCE, and Docker compose\e[0m"
	exit 0
fi

USER=/home/intel
cd $USER
DIR=$PWD/pipeline-server
MODEL_PATH=$PWD

if [ -d "$DIR" ]; then
	echo "Success"
else
    git clone https://github.com/dlstreamer/pipeline-server.git
fi

cd $DIR/
./docker/build.sh
echo -e "\e[1;32mdlstreamer-pipeline-server-gstreamer docker image is been created\e[0m"
docker images dlstreamer-pipeline-server-gstreamer:latest
echo -e "\e[1;32mSuccessfully installed the package. To run the application, please run the enable.sh file.\e[0m"
echo -e "\e[1;31mFor further queries please follow below URL\e[0m"
echo -e "\e[1;32m\nhttps://github.com/dlstreamer/pipeline-server\e[0m"

