include ./sdf

{.link: "<###>usd/build/inst/lib/libusd_ms.{!!!}".}

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

""".}

const
    usdStageHeader = "<###>usd/build/inst/include/pxr/usd/usd/stage.h"
    usdPrimHeader = "<###>usd/build/inst/include/pxr/usd/usd/prim.h"
    usdAttributeHeader = "<###>usd/build/inst/include/pxr/usd/usd/attribute.h"
    usdPrimRangeHeader = "<###>usd/build/inst/include/pxr/usd/usd/primRange.h"

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

proc getName(p: UsdPrim): cstring {. importcpp: "(char*)#.GetName().data()" .}

proc getAttribute(p: UsdPrim, s: cstring): UsdAttribute {. importcpp: "#.GetAttribute(pxr::TfToken(#))" .}

proc hasAttribute(p: UsdPrim, s: cstring): bool {. importcpp: "#.HasAttribute(pxr::TfToken(#))" .}

proc get(a: UsdAttribute): cint {. importcpp: "getIntValue(#)" .}

when isMainModule:
    echo "---------------------------------------------------------"
    echo "Usd module"
    echo ""
    echo ""

    var 
        stage = openUsdStage("./data/layer.usd")
        rootLayer = stage.getRootLayer()
        traversal = stage.traverse()
        t_curr = traversal.iter_begin()
        t_end = traversal.iter_end()

    #echo "Opened stage rooted at ", $rootLayer.getRealPath() 
    while not iter_eq(t_curr, t_end):
        var prim = t_curr.get()
        t_curr = t_curr.iter_next()
        echo "Prim info: ", prim.getName()

        if prim.hasAttribute("foo"):
            var attr = prim.getAttribute("foo")
            echo "Attribute value: ", attr.get()

    echo ""
    echo "---------------------------------------------------------"
    echo ""
    echo ""
