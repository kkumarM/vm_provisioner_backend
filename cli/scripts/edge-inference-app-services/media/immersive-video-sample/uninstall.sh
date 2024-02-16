#!/bin/bash

#cd ../..

DIR="Immersive-Video-Sample"
if [ -d "$DIR" ]; then
   # Take action if $DIR exists. #
   echo "Deleting cloned directory"
   sudo rm -rf Immersive-Video-Sample 
else
   echo "Git repository does not exist to Delete"
fi
