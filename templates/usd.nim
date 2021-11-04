include ./sdf
include ./vt

{.link: "<###>lib/libusd_ms.{!!!}".}

{.emit:"""
#include <pxr/pxr.h>
#include <pxr/usd/usd/common.h>
#include <pxr/usd/usd/prim.h>
#include <pxr/usd/usd/attribute.h>
#include <algorithm>
using namespace pxr;

// Still figuring out how to handle generics around this so temp
// TODO: remove this workaround along with the TfToken wrapping
auto getIntValue = [](pxr::UsdAttribute& attr) {
    int i; 
    attr.Get(&i);
    return i; 
};

auto getVtValue = [](pxr::UsdAttribute& attr) {
    pxr::VtValue v;
    attr.Get(&v);
    return v; 
};


""".}

const
    usdStageHeader = "<###>include/pxr/usd/usd/stage.h"
    usdPrimHeader = "<###>include/pxr/usd/usd/prim.h"
    usdAttributeHeader = "<###>include/pxr/usd/usd/attribute.h"
    usdPrimRangeHeader = "<###>include/pxr/usd/usd/primRange.h"

type
    UsdStage {.header: usdStageHeader,
             importcpp: "pxr::UsdStage".} = object

    UsdStageRefPtr {. header: usdStageHeader,
                      importcpp: "pxr::UsdStageRefPtr".} = object

    UsdPrim {. header: usdPrimHeader,
               importcpp: "pxr::UsdPrim" .} = object

    UsdPrimRange {. header: usdPrimRangeHeader,
                    importcpp: "pxr::UsdPrimRange" .} = object

    UsdPrimRangeIter {. header: usdPrimRangeHeader,
                        importcpp: "pxr::UsdPrimRange::iterator" .} = object

    UsdAttribute {. header: usdAttributeHeader,
                    importcpp: "pxr::UsdAttribute" .} = object


proc openUsdStage(path: cstring): UsdStageRefPtr {. importcpp: "UsdStage::Open(@)",
                                                    header: usdStageHeader .}

proc getRootLayer(s: UsdStageRefPtr): SdfLayerRefPtr {. importcpp: "#->GetRootLayer()",
                                                        header: usdStageHeader .}

proc traverse(s: UsdStageRefPtr): UsdPrimRange {. importcpp: "#->Traverse()",
                                                  header: usdStageHeader .}

proc iter_end(pr: UsdPrimRange): UsdPrimRangeIter {. importcpp: "std::end(@)" .}

proc iter_begin(pr: UsdPrimRange): UsdPrimRangeIter {. importcpp: "std::begin(@)" .}

proc iter_next(pr: UsdPrimRangeIter): UsdPrimRangeIter {. importcpp: "std::next(@)" .}

proc iter_eq(pr1: UsdPrimRangeIter, pr2: UsdPrimRangeIter): bool {. importcpp: "# == #" .}

proc get(pr: UsdPrimRangeIter): UsdPrim {. importcpp: "*#" .}

# TODO: Still figuring out naming conventions, but worry about
# this once we have most of the useful parts stubbed out and 
# the tests ported
type 
    TUsdPrimRange = object
        impl: UsdPrimRange

proc iter(pr: UsdPrimRange) : TUsdPrimRange =
    TUsdPrimRange(impl: pr)

iterator items(range: TUsdPrimRange): UsdPrim =
    var current = iter_begin(range.impl)
    var last = iter_end(range.impl) 
    while not iter_eq(current, last):
        yield current.get()
        current = current.iter_next()


proc getName(p: UsdPrim): cstring {. importcpp: "(char*)#.GetName().data()" .}

proc getAttribute(p: UsdPrim, s: cstring): UsdAttribute {. importcpp: "#.GetAttribute(pxr::TfToken(#))" .}

proc hasAttribute(p: UsdPrim, s: cstring): bool {. importcpp: "#.HasAttribute(pxr::TfToken(#))" .}

proc get(a: UsdAttribute): VtValue {. importcpp: "getVtValue(#)" .}

proc getTypeName(a: UsdAttribute): SdfValueTypeName {. importcpp: "#.GetTypeName()" .}

when isMainModule:
    echo "---------------------------------------------------------"
    echo "Usd module"
    echo ""
    echo ""

    var 
        stage = openUsdStage("./data/layer.usd")
        rootLayer = stage.getRootLayer()
        traversal = stage.traverse()

    echo "Nim style iterator, for USD Prim Range"

    for prim in iter(stage.traverse()):
        echo "Prim info: ", prim.getName()

        if prim.hasAttribute("foo"):
            var 
                attr = prim.getAttribute("foo")
                value = attr.get()
                tn = attr.getTypeName()
            echo "Attribute type: ", $tn
            echo "Attribute value: ", value

    echo ""
    echo "---------------------------------------------------------"
    echo ""
    echo ""
