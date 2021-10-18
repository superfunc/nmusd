#!/usr/bin/bash

curr=$(pwd)
export LD_LIBRARY_PATH="$curr/deps/usd/build/inst/lib/:$LD_LIBRARY_PATH" 
export PXR_PLUGINPATH_NAME="$curr/deps/usd/build/inst/lib/usd/"
export TF_DEBUG="SDF*"

for f in ./bin/*; do
    ./$f
done
