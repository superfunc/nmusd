{.link: "<###>usd/build/inst/lib/libusd_ms.{!!!}".}

{.emit:"""
#include <pxr/pxr.h>
using namespace pxr;
""".}

const
    gfHalfHeader = "<###>usd/build/inst/include/pxr/base/gf/half.h"

type
    GfHalf {.header: gfHalfHeader,
             importcpp: "GfHalf".} = object

proc CreateGfHalf(): GfHalf {. header: gfHalfHeader,
                               importcpp: "GfHalf()" .}

echo "Gf module"
