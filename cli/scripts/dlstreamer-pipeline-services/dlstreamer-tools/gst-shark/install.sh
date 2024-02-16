#!/bin/bash

USER=/home/intel

cd $USER
DIR=$PWD/gst-shark
OPTIONS="--prefix /usr/ --libdir /usr/lib/x86_64-linux-gnu/"
if [ -d "$DIR" ]; then
        echo "Success"
else
    git clone https://github.com/RidgeRun/gst-shark/
fi
if [ "$(gst-launch-1.0 --version)" -lt 1.7.1 ]; then
    echo -e "\e[1;31mgst-lauch-1.0 version should be greater than 1.7.1\e[0m"
    exit 1
else
    echo -e "\e[1;32mSuccess. gst-launch-1.0 version matches.\e[0m"
    sudo apt install libgstreamer1.0-dev 
    sudo apt install graphviz libgraphviz-dev
    sudo apt install octave epstool babeltrace
    sudo apt-get install gtk-doc-tools
    cd $DIR
    ./autogen.sh $OPTIONS
    make
    sudo make install
    echo -e "\e[1;32mSuccessfully installed Gst-Shark.\e[0m"
fi
echo -e "\e[1;31mFor further queries please follow below URL\e[0m"
echo -e "\e[1;32m\nhttps://developer.ridgerun.com/wiki/index.php/GstShark_-_Getting_Started\e[0m"

