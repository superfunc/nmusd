{.link: "<###>usd/build/inst/lib/libvt.so".}

{.emit:"""
using namespace pxr;
""".}

const
    vtValueHeader = "<###>usd/build/inst/include/pxr/base/vt/value.h"

type
    VtValue {.header: vtValueHeader,
              importcpp: "VtValue".} = object

proc CreateVtValue(): VtValue {. header: VtValue, 
                                 importcpp: "VtValue()" .}

