#!/usr/bin/env bash

# set -o xtrace 

curr=$(pwd)

# nmusd version number (major/minor/patch)
mj="0"
mn="0"
pt="1"

nm_usdlib_path="${curr}/deps/usd/build/inst/"

if [ -z "${NMUSD_CUSTOM_USD_BUILD_PATH}" ]; then
    echo "USD must be supplied as env var: NMUSD_CUSTOM_USD_BUILD_PATH"
    exit 1
else
    nm_usdlib_path="${NMUSD_CUSTOM_USD_BUILD_PATH}"
fi

lib_ext="so"
if [[ $OSTYPE == "darwin"* ]]; then
    lib_ext="dylib"
fi

for f in ./templates/*.nim; do
    generated_name=$(echo "$f" | sed -e "s/templates/src/g")
    binary_name=$(echo "$generated_name" | rev | cut -d'.' -f2 | cut -d'/' -f1 | rev)
    sed "s@<###>@$nm_usdlib_path@g" $f > /tmp/nmusd_build_artifact
    sed "s@{!!!}@$lib_ext@g" /tmp/nmusd_build_artifact > $generated_name
    
    export _INCLUDES="${nm_usdlib_path}/include/"
    export _LIBDIR="${nm_usdlib_path}/lib/"
    nim cpp --cincludes:"$_INCLUDES" \
            --clibdir:"$_LIBDIR" \
            --passL:-lusd_ms \
            --passL:-ltbb \
            -o:./bin/$binary_name \
            $generated_name

done
