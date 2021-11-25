#!/usr/bin/env bash

# set -o xtrace 

curr=$(pwd)

# nmusd version number (major/minor/patch)
mj="0"
mn="0"
pt="1"

nm_usdlib_path="${curr}/deps/usd/build/inst/"

if [ -z "${NMUSD_CUSTOM_USD_BUILD_PATH}" ]; then
    if ! [ -d "deps/usd" ]; then
        echo "Performing initial build of USD"
        git clone --depth 1 --branch v21.08 https://github.com/pixaranimationstudios/usd ./deps/usd/
        pushd deps/usd
        mkdir -p build/inst
        pushd build
        build_dir=$(pwd)
        cmake -DPXR_ENABLE_PYTHON_SUPPORT=OFF \
              -DPXR_BUILD_USD_TOOLS=OFF       \
              -DPXR_BUILD_IMAGING=OFF         \
              -DPXR_BUILD_MONOLITHIC=ON       \
              -DPXR_BUILD_TUTORIALS=OFF       \
              -DPXR_BUILD_EXAMPLES=OFF        \
              -DPXR_BUILD_TESTS=OFF           \
              -DPXR_SET_INTERNAL_NAMESPACE="_nmusd_v${mj}_${mn}_${pt}" \
              -DCMAKE_INSTALL_PREFIX="${build_dir}/inst" \
              -DCMAKE_MACOSX_RPATH=OFF        \
              ..
        make -j8
        make install
        popd
        popd
    else
        echo "USD already built, building nim bindings"
    fi
else
    nm_usdlib_path="${NMUSD_CUSTOM_USD_BUILD_PATH}"
fi

lib_ext="so"
if [[ $OSTYPE == "darwin"* ]]; then
    lib_ext="dylib"
fi

boost="${NMUSD_BOOST_HEADER_ROOT_PATH}"
tbb="${NMUSD_TBB_HEADER_ROOT_PATH}"
tbb_l="${NMUSD_TBB_LINK_PATH}"

for f in ./templates/*.nim; do
    generated_name=$(echo "$f" | sed -e "s/templates/src/g")
    binary_name=$(echo "$generated_name" | rev | cut -d'.' -f2 | cut -d'/' -f1 | rev)
    sed "s@<###>@$nm_usdlib_path@g" $f > /tmp/nmusd_build_artifact
    sed "s@{!!!}@$lib_ext@g" /tmp/nmusd_build_artifact > $generated_name
    
    export _INCLUDES="${nm_usdlib_path}/include/"
    export _LIBDIR="${nm_usdlib_path}/lib/"
    nim cpp --cincludes:"$_INCLUDES" \
            --cincludes:"$boost" \
            --cincludes:"$tbb" \
            --clibdir:"$_LIBDIR" \
            --clibdir:"$tbb_l" \
            --passL:-lusd_ms \
            --passL:-ltbb \
            -o:./bin/$binary_name \
            $generated_name

done
