{.link: "<###>usd/build/inst/lib/libusd_ms.{!!!}".}

{.emit:"""
#include <pxr/pxr.h>
using namespace pxr;
""".}

const
    gfHalfHeader = "<###>usd/build/inst/include/pxr/base/gf/half.h"
    gfSize2Header = "<###>usd/build/inst/include/pxr/base/gf/size2.h"
    gfSize3Header = "<###>usd/build/inst/include/pxr/base/gf/size3.h"

type
    GfHalf {.header: gfHalfHeader,
             importcpp: "GfHalf".} = object

    GfSize2 {.header: gfSize2Header,
              importcpp: "GfSize2".} = object

    GfSize3 {.header: gfSize3Header,
              importcpp: "GfSize3".} = object


proc CreateGfHalf(): GfHalf {. header: gfHalfHeader,
                               importcpp: "GfHalf()" .}


proc CreateGfSize2(): GfSize2 {. header: gfSize2Header,
                                importcpp: "GfSize2()" .}

proc CreateGfSize3(): GfSize3 {. header: gfSize3Header,
                                 importcpp: "GfSize3()" .}



echo "Gf module"

var 
    s2 = CreateGfSize2()
    s3 = CreateGfSize3()

echo "Created types"