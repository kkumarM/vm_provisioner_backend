#!/bin/bash
USER=/home/intel

cd $USER
DIR=$PWD/pipeline-zoo

if [[ $(which docker) && $(docker --version) ]]; then
      echo -e "\e[1;33mDocker is present in the system\e[0m"
else
        echo -e "\e[1;31mPlease install Docker, DockerCE, and Docker compose\e[0m"
        exit 0
fi


if [ -d "$DIR" ]; then
    echo "Success"
    sudo ./pipeline-zoo/tools/docker/run.sh
    echo -e "\e[1;32mYou have successfully lauched Pipeline zoo\e[0m"
    echo "-- To list pipelines, run: pipebench list"
    echo "-- To download pipeline, run: pipebench download od-h264-ssd-mobilenet-v1-coco"
    echo "-- Measure Single Stream Throughput, run: pipebench run od-h264-ssd-mobilenet-v1-coco"
    echo "-- Measure Stream Density, run: pipebench run --measure density od-h264-ssd-mobilenet-v1-coco"
else
    echo -e "\e[1;31mError: ${DIR} not found. Please run installation script.\e[0m"
fi
