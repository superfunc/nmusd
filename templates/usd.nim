include ./sdf

{.link: "<###>usd/build/inst/lib/libusd_ms.{!!!}".}

{.emit:"""
#include <pxr/pxr.h>
#include <pxr/usd/usd/common.h>
#include <algorithm>
using namespace pxr;
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
    

    echo ""
    echo "---------------------------------------------------------"
    echo ""
    echo ""
