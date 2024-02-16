#!/bin/bash

cd CDN-Transcode-Sample

cd build

make stop_helm

cd ../..

DIR="CDN-Transcode-Sample"
if [ -d "$DIR" ]; then
   # Take action if $DIR exists. #
   echo "Deleting cloned directory"
   sudo rm -rf CDN-Transcode-Sample
else
   echo "Git repository does not exist to Delete"
fi

