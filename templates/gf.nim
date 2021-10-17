{.link: "<###>usd/build/inst/lib/libgf.so".}

{.emit:"""
using namespace pxr;
""".}

const
    gfHalfHeader = "<###>usd/build/inst/include/pxr/base/gf/half.h"

type
    GfHalf {.header: gfHalfHeader,
             importcpp: "GfHalf".} = object

proc CreateGfHalf(): GfHalf {. header: gfHalfHeader,
                               importcpp: "GfHalf()" .}

