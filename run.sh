#!/usr/bin/bash

if ! [ -f "./bin/samples" ]; then
    echo "No samples built, run build.sh"
    exit 1 
fi

curr=$(pwd)
export LD_LIBRARY_PATH="$curr/deps/usd/build/inst/lib/:$LD_LIBRARY_PATH" 
export PXR_PLUGINPATH_NAME="$curr/deps/usd/build/inst/lib/usd/"
./bin/samples
