{.link: "<###>usd/build/inst/lib/libusd_ms.so".}

{.emit:"""
#include <pxr/pxr.h>
#include <pxr/usd/sdf/layer.h>
#include <string>
#include <cstdio>
using namespace pxr;

NIM_EXTERNC
void priv_dumpLayerContentsC(const char* path) 
{
    pxr::SdfLayerRefPtr layer = pxr::SdfLayer::FindOrOpen(path);
    pxr::SdfLayerRefPtr layer2 = pxr::SdfLayer::FindOrOpen(path);
    std::string result;
    layer2->ExportToString(&result); 
    printf("%s\n", result.c_str());
}

""".}

const
    sdfLayerHeader = "<###>usd/build/inst/include/pxr/usd/sdf/layer.h"
    sdfHandlesHeader = "<###>usd/build/inst/include/pxr/usd/sdf/declareHandles.h"
    sdfPrimHeader = "<###>usd/build/inst/include/pxr/usd/sdf/primSpec.h"

type
    SdfLayer {.header: sdfLayerHeader,
               importcpp: "SdfLayer".} = object {. inheritable .}

    SdfLayerRefPtr {. header: sdfHandlesHeader,
                      importcpp: "SdfLayerRefPtr".} = object

    SdfPrimSpec {. header: sdfPrimHeader,
                   importcpp: "SdfPrimSpec".} = object


proc dumpLayer(s: cstring): void {. importcpp: "priv_dumpLayerContentsC(@)",
                                    nodecl}

proc openSdfLayer(s: cstring): SdfLayerRefPtr {. importcpp: "SdfLayer::FindOrOpen(@)",
                                                 header: sdfLayerHeader .} 

proc getRealPath(l: SdfLayerRefPtr): cstring {. importcpp: "#->GetRealPath().c_str()",
                                                header: sdfLayerHeader .} 


#proc getPsuedoroot(l: SdfLayerRefPtr): SdfPrimSpec {. importcpp: "#->GetPseudoRoot()",
#                                                      header: sdfPrimHeader .} 


when isMainModule:
    var 
        l = openSdfLayer("./data/layer.sdf")
        path = $l.getRealPath()
    echo "Opened layer at ", path