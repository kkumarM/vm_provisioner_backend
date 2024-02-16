#!/bin/bash

if [[ $(which docker) && $(docker --version) ]]; then
      echo -e "\e[1;33mDocker is present in the system\e[0m"
else
        echo -e "\e[1;31mPlease install Docker, DockerCE, and Docker compose\e[0m"
        exit 0
fi

result=$( sudo docker images -q dlstreamer-pipeline-server-gstreamer )

if [[ -n "$result" ]]; then
	echo -e "\e[1;32mdlstreamer-pipeline-server-gstreamer docker image is present\e[0m"
else
	echo -e "\e[1;31mdlstreamer-pipeline-server-gstreamer docker image is not present. Please run installation script\e[0m"
	exit 0
fi


USER=/home/intel
DIR=$USER/pipeline-server

if [ -d "$DIR" ]; then
	cd $DIR
	./docker/run.sh -v /tmp:/tmp	
else
        echo -e "\e[1;31mFolder doesnot exist. Please install the package first.\e[0m"
fi

