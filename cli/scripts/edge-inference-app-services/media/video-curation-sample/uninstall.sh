#!/bin/bash

cd Video-Curation-Sample

cd build

#make stop_docker_compose 
#make stop_docker_swarm

make stop_kubernetes


cd ../..

DIR="Video-Curation-Sample"
if [ -d "$DIR" ]; then
   # Take action if $DIR exists. #	
   echo "Deleting cloned directory"
   sudo rm -rf Video-Curation-Sample
else
   echo "Git repository does not exist to Delete"   	
fi
