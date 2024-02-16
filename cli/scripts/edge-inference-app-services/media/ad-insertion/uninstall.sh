#!/bin/bash

cd Ad-Insertion-Sample

cd build

#make stop_docker_swarm      

make stop_kubernetes

cd ../..

DIR="Ad-Insertion-Sample"
if [ -d "$DIR" ]; then
   # Take action if $DIR exists. #
   echo "Deleting cloned directory"
   sudo rm -rf Ad-Insertion-Sample
else
   echo "Git repository does not exist to Delete"
fi

