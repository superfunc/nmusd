{.link: "<###>usd/build/inst/lib/libsdf.so".}

{.emit:"""
using namespace pxr;
""".}

const
    sdfPathHeader = "<###>usd/build/inst/include/pxr/usd/sdf/path.h"

type
    SdfPath {.header: sdfPathHeader,
              importcpp: "SdfPath".} = object
    
proc CreateSdfPath(): SdfPath {. header: sdfPathHeader, 
                                 importcpp: "SdfPath()" .}

