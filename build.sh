#!/usr/bin/bash

if ! [ -d "deps/usd" ]; then
    echo "Performing initial build of USD"
    git clone https://github.com/pixaranimationstudios/usd ./deps/usd/
    pushd deps/usd
    mkdir -p build/inst
    pushd build
    python3 ../build_scripts/build_usd.py --no-python --no-tools \
                                         --no-docs --no-tutorials --no-imaging \
                                         --no-tests --no-examples --verbose (pwd)/inst
 
    popd
    popd
else
    echo "USD already built, building nim bindings"
fi

nim cpp --cincludes:/home/superfunc/code/pkgs/usd/build/inst/include/ \
        --clibdir:/home/superfunc/code/pkgs/usd/build/inst/lib/ \
        --passL:-ltf \
        -o:samples \
        samples
