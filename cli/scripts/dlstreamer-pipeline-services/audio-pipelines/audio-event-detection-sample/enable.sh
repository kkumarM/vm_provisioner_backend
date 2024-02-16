#!/bin/bash
INTEL_OPENVINO_DIR=/opt/intel/openvino_2021
USER=/home/intel
DIR=$USER/dlstreamer

if [ -d "$DIR" ]; then
    echo -e "\e[1;32mSuccess\e[0m"
    source $INTEL_OPENVINO_DIR/bin/setupvars.sh
    export MODELS_PATH=$USER
    cd $DIR/samples/gst_launch/audio_detect
    INPUT_PATH=$PWD/how_are_you_doing.wav
    ./audio_event_detection.sh $INPUT_PATH
    echo -e "\e[1;32mSuccessfully installed the package. To run the application, please run enable.sh file.\e[0m"
else
    echo -e "\e[1;31mError: ${DIR} not found. Please run installation script.\e[0m"
fi
