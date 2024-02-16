#!/bin/bash

INTEL_OPENVINO_DIR=/opt/intel/openvino_2021
#sudo chmod 777 /etc/environment
#sudo echo "http_proxy=http://proxy-dmz.intel.com:911
#https_proxy=http://proxy-dmz.intel.com:911
#HTTP_PROXY=http://proxy-dmz.intel.com:911
#HTTPS_PROXY=http://proxy-dmz.intel.com:911
#ftp_proxy=http://proxy-dmz.com:911
#NO_PROXY=localhost,127.0.0.1
#no_proxy=localhost,127.0.0.1" > /etc/environment

#source /etc/environment
export no_proxy="localhost,127.0.0.1"

if [ -d "$INTEL_OPENVINO_DIR" ]; then
        echo -e "\e[1;32mOpenVINO toolkit is already installed\e[0m"
else
        wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18319/l_openvino_toolkit_p_2021.4.752.tgz
        sudo apt-get update
        sudo apt-get install cpio
        tar -xvzf l_openvino_toolkit_p_2021.4.752.tgz
        cd l_openvino_toolkit_p_2021.4.752
        sed -i 's/decline/accept/g' silent.cfg
        sudo ./install.sh -s silent.cfg
        cd /opt/intel/openvino_2021/install_dependencies
        sudo -E ./install_openvino_dependencies.sh
        echo -e "\e[1;32mSuccessfully installed OpenVINO toolkit\e[0m"
fi

USER=/home/intel
MODEL_PATH=$USER
DIR=$USER/dlstreamer
cd $USER
if [ -d "$DIR" ]; then
        echo -e "\e[1;32mSuccess\e[0m"
else
    git clone https://github.com/dlstreamer/dlstreamer.git
fi
export INTEL_OPENVINO_DIR=$INTEL_OPENVINO_DIR
export MODELS_PATH=$MODEL_PATH
pip3 install numpy networkx onnx
pip3 install -r $INTEL_OPENVINO_DIR/deployment_tools/open_model_zoo/tools/downloader/requirements.in
cd $DIR/samples
sh ./download_models.sh
echo -e "\e[1;32mSuccessfully installed the packages. To run the application please run the enable.sh file.\e[0m"

echo -e "\e[1;31mFor further queries please follow below URL\e[0m"
echo -e "\e[1;32m\nhttps://github.com/dlstreamer/dlstreamer/tree/master/samples/gst_launch/audio_detect\e[0m"

