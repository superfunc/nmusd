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
for f in ./templates/*.nim.template; do
    gen_name_="${f::-9}"
    generated_name=$(echo "$gen_name_" | sed -e "s/templates/src/g")

    echo "GEN: $generated_name"
    binary_name=$(echo "$generated_name" | rev | cut -d'.' -f2 | cut -d'/' -f1 | rev)
    sed "s@<###>@$curr\/deps\/@g" $f > $generated_name

    export _INCLUDES="${curr}/deps/usd/build/inst/include/"
    export _LIBDIR="${curr}/deps/usd/build/inst/lib/"
    nim cpp --cincludes:"$_INCLUDES" \
            --clibdir:"$_LIBDIR" \
            --passL:-ltf \
            -o:./bin/$base_name \
            $generated_name

done
