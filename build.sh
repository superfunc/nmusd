#!/usr/bin/bash

set -o xtrace 


if ! [ -d "deps/usd" ]; then
    echo "Performing initial build of USD"
    git clone https://github.com/pixaranimationstudios/usd ./deps/usd/
    pushd deps/usd
    mkdir -p build/inst
    pushd build
    build_dir=$(pwd)
    python3 ../build_scripts/build_usd.py --no-python --no-tools \
                                         --no-docs --no-tutorials --no-imaging \
                                         --no-tests --no-examples --verbose "${build_dir}/inst"
 
    popd
    popd
else
    echo "USD already built, building nim bindings"
fi

curr=$(pwd)
if ! [ -f "./samples.nim" ]; then
    echo "Generating nim binding file"
    sed "s/<###>/$curr\//g" samples.nim.template >> samples.nim
fi

export _INCLUDES="${curr}/deps/usd/build/inst/include/"
export _LIBDIR="${curr}/deps/usd/build/inst/lib/"
nim cpp --cincludes:"$_INCLUDES" \
        --clibdir:"$_LIBDIR" \
        --passL:-ltf \
        -o:samples \
        samples
