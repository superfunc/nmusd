{.link: "<###>usd/build/inst/lib/libusd_ms.so".}

{.emit:"""
#include <pxr/pxr.h>
#include <pxr/usd/sdf/declareSpec.h>
#include <pxr/usd/sdf/declareHandles.h>
#include <pxr/usd/sdf/spec.h>
#include <pxr/usd/sdf/primSpec.h>
#include <pxr/usd/sdf/layer.h>

#include <string>
#include <cstdio>
#include <vector>
using namespace pxr;

void priv_dumpLayerContentsC(const char* path) 
{
    pxr::SdfLayerRefPtr layer = pxr::SdfLayer::FindOrOpen(path);
    pxr::SdfLayerRefPtr layer2 = pxr::SdfLayer::FindOrOpen(path);
    std::string result;
    layer2->ExportToString(&result); 
    printf("%s\n", result.c_str());
}

std::vector<pxr::SdfPrimSpecHandle> priv_getRootPrimsC(pxr::SdfLayerRefPtr layer) 
{
    std::vector<pxr::SdfPrimSpecHandle> rootPrims;
    for(const pxr::SdfPrimSpecHandle prim : layer->GetRootPrims()) {
        rootPrims.push_back(prim);
    }

    return rootPrims;
}

pxr::SdfPrimSpecHandle priv_pop(std::vector<pxr::SdfPrimSpecHandle>& v) 
{
    pxr::SdfPrimSpecHandle item = *v.rbegin(); 
    v.pop_back();
    return item;
}

""".}

const
    sdfLayerHeader = "<###>usd/build/inst/include/pxr/usd/sdf/layer.h"
    sdfHandlesHeader = "<###>usd/build/inst/include/pxr/usd/sdf/declareHandles.h"
    sdfPrimHeader = "<###>usd/build/inst/include/pxr/usd/sdf/primSpec.h"

type
    StdVec[T] {. header: "<vector>", importcpp: "std::vector" .} = object

    SdfLayer {.header: sdfLayerHeader,
               importcpp: "SdfLayer".} = object {. inheritable .}

    SdfLayerRefPtr {. header: sdfHandlesHeader,
                      importcpp: "SdfLayerRefPtr".} = object

    SdfPrimSpec {. header: sdfPrimHeader,
                   importcpp: "SdfPrimSpec".} = object

    SdfPrimSpecHandle {. header: sdfHandlesHeader,
                         importcpp: "pxr::SdfPrimSpecHandle".} = object

proc empty(v: StdVec[SdfPrimSpecHandle]): bool {. importcpp: "#.empty()", header: "<vector>" .}

proc next(v: StdVec[SdfPrimSpecHandle]): SdfPrimSpecHandle  {. importcpp: "priv_pop(@)" .}

proc getRootPrims(l: SdfLayerRefPtr): StdVec[SdfPrimSpecHandle] {. importcpp: "priv_getRootPrimsC(@)" .}

proc dumpLayer(s: cstring): void {. importcpp: "priv_dumpLayerContentsC(@)",
                                    nodecl}

proc openSdfLayer(s: cstring): SdfLayerRefPtr {. importcpp: "SdfLayer::FindOrOpen(@)",
                                                 header: sdfLayerHeader .} 

proc getRealPath(l: SdfLayerRefPtr): cstring {. importcpp: "#->GetRealPath().c_str()",
                                                header: sdfLayerHeader .} 

proc getPsuedoroot(l: SdfLayerRefPtr): SdfPrimSpecHandle {. importcpp: "#->GetPseudoRoot()",
                                                            header: sdfPrimHeader .} 

proc getName(p: SdfPrimSpecHandle): cstring {. importcpp: "#->GetName().c_str()" 
                                               header: sdfPrimHeader .}

when isMainModule:
    var 
        l = openSdfLayer("./data/layer.sdf")
        path = $l.getRealPath()
        proot = l.getPsuedoroot()
        name = $proot.getName()
        rootPrims = l.getRootPrims()

    while not rootPrims.empty():
        var r = rootPrims.next()
        echo "root prim name: ", r.getName()

    echo "Opened layer at ", path, " with pseudoroot: ", name