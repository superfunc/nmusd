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


type
    SdfLayer {.header: sdfLayerHeader,
               importcpp: "SdfLayer".} = object {. inheritable .}
    

proc dumpLayer(s: cstring): void {. importcpp: "priv_dumpLayerContentsC(@)",
                                    nodecl}

when isMainModule:
    echo "Sdf module"
    dumpLayer("./data/layer.sdf")