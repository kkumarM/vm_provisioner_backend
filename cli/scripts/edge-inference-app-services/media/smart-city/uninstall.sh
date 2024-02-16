#!/bin/bash

cd Smart-City-Sample

cd build

#make stop_docker_swarm      

make stop_kubernetes

cd ../..

DIR="Smart-City-Sample"
if [ -d "$DIR" ]; then
   # Take action if $DIR exists. #
   echo "Deleting cloned directory"
   sudo rm -rf Smart-City-Sample
else
   echo "Git repository does not exist to Delete"
fi

