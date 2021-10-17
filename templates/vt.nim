{.link: "<###>usd/build/inst/lib/libusd_ms.so".}

{.emit:"""
#include <pxr/pxr.h>
using namespace pxr;
""".}

const
    vtValueHeader = "<###>usd/build/inst/include/pxr/base/vt/value.h"

type
    VtValue {.header: vtValueHeader,
              importcpp: "VtValue".} = object

proc CreateVtValue(): VtValue {. header: vtValueHeader, 
                                 importcpp: "VtValue()" .}

echo "Vt module"
