{.link: "<###>usd/build/inst/lib/libusd_ms.so".}

{.emit:"""
#include <pxr/pxr.h>
using namespace pxr;
""".}

const
    sdfPathHeader = "<###>usd/build/inst/include/pxr/usd/sdf/path.h"

type
    SdfPath {.header: sdfPathHeader,
              importcpp: "SdfPath".} = object
    
proc CreateSdfPath(): SdfPath {. header: sdfPathHeader, 
                                 importcpp: "SdfPath()" .}

echo "Sdf module"
