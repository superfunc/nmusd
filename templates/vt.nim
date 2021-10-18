{.link: "<###>usd/build/inst/lib/libusd_ms.so".}

{.emit:"""
#include <pxr/pxr.h>
using namespace pxr;
""".}

import options

const
    vtValueHeader = "<###>usd/build/inst/include/pxr/base/vt/value.h"

type
    VtValue {.header: vtValueHeader,
              importcpp: "VtValue".} = object

proc createVtValue(): VtValue {. header: vtValueHeader, 
                                 importcpp: "VtValue()" .}

proc createVtValue(k: cint): VtValue {. header: vtValueHeader, 
                                        importcpp: "VtValue(@)" .}

proc isEmpty(v: VtValue): bool {. header: vtValueHeader,
                                  importcpp: "#.IsEmpty()" .}

proc priv_uncheckedGet(v: VtValue): cint {. header: vtValueHeader,
                                            importcpp: "#.UncheckedGet<int>()" .}

proc priv_swap(v: VtValue, k: cint): void {. header: vtValueHeader,
                                             importcpp: "#.Swap<int>(@)" .}

proc priv_isHolding(v: VtValue): bool {. header: vtValueHeader,
                                         importcpp: "#.IsHolding<int>()" .}

proc priv_take(k: cint): VtValue {. header: vtValueHeader,
                                    importcpp: "VtValue::Take(@)" .}

proc get(v: VtValue): Option[cint] =
    if v.isEmpty():
        none[cint]()
    else:
        some(v.priv_uncheckedGet())

proc set(v: VtValue, k: cint): VtValue =
    priv_take(k)

echo "Vt module"
echo "--------------------------------------------------"

let x : cint = 5
var v = createVtValue(61)
echo "Is empty?", v.isEmpty(), " ", repr(v.addr)
echo "Is holding?", priv_isHolding(v)
echo "Get value: ", v.get()
v = v.set(65)
echo "Is empty?", v.isEmpty(), " ", repr(v.addr)
echo "Is holding?", priv_isHolding(v)
echo "Get value: ", v.get()

echo ""

var v2 = createVtValue()
echo "Is empty?", v2.isEmpty(), " ", repr(v2.addr)
echo "Is holding?", priv_isHolding(v2)
v2 = v2.set(65)
echo "Is empty?", v2.isEmpty(), " ", repr(v2.addr)
echo "Is holding?", priv_isHolding(v2)
echo "Get value: ", v2.get()

echo "--------------------------------------------------"
echo "End Vt module"
echo "--------------------------------------------------"