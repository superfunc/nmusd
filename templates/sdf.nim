{.link: "<###>lib/libusd_ms.{!!!}".}

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
#include <iostream>
#include <sstream>
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

std::string to_string(pxr::SdfValueTypeName t) {
    std::stringstream s;
    s << t; 
    return s.str();
}

""".}

const
    sdfLayerHeader = "<###>include/pxr/usd/sdf/layer.h"
    sdfHandlesHeader = "<###>include/pxr/usd/sdf/declareHandles.h"
    sdfPrimHeader = "<###>include/pxr/usd/sdf/primSpec.h"
    sdfPropertyHeader = "<###>include/pxr/usd/sdf/propertySpec.h"
    sdfTypesHeader = "<###>include/pxr/usd/sdf/types.h"

type
    StdVec[T] {. header: "<vector>", importcpp: "std::vector" .} = object

    SdfLayer {.header: sdfLayerHeader,
               importcpp: "pxr::SdfLayer".} = object {. inheritable .}

    SdfLayerRefPtr {. header: sdfHandlesHeader,
                      importcpp: "pxr::SdfLayerRefPtr".} = object

    SdfPropertySpec {. header: sdfPropertyHeader,
                   importcpp: "pxr::SdfPropertySpec".} = object

    SdfPropertySpecHandle {. header: sdfHandlesHeader,
                         importcpp: "pxr::SdfPropertySpecHandle".} = object

    SdfPrimSpec {. header: sdfPrimHeader,
                   importcpp: "pxr::SdfPrimSpec".} = object

    SdfPrimSpecHandle {. header: sdfHandlesHeader,
                         importcpp: "pxr::SdfPrimSpecHandle".} = object

    SdfValueTypeName {. header: sdfTypesHeader,
                        importcpp: "pxr::SdfValueTypeName".} = object

# Many many sdfvaluetypenames types
proc SdfValueTypeNameInt(): SdfValueTypeName {. header: sdfTypesHeader, importcpp: "(SdfValueTypeNames->Int)" .}
proc SdfValueTypeNameFloat(): SdfValueTypeName {. header: sdfTypesHeader, importcpp: "(SdfValueTypeNames->Float)" .}
proc SdfValueTypeNameHalf(): SdfValueTypeName {. header: sdfTypesHeader, importcpp: "(SdfValueTypeNames->Half)" .}
proc SdfValueTypeNameDouble(): SdfValueTypeName {. header: sdfTypesHeader, importcpp: "(SdfValueTypeNames->Double)" .}

proc empty(v: StdVec[SdfPrimSpecHandle]): bool {. importcpp: "#.empty()", header: "<vector>" .}

proc next(v: StdVec[SdfPrimSpecHandle]): SdfPrimSpecHandle  {. importcpp: "priv_pop(@)" .}

proc getRootPrims(l: SdfLayerRefPtr): StdVec[SdfPrimSpecHandle] {. importcpp: "priv_getRootPrimsC(@)" .}

proc dumpLayer(s: cstring): void {. importcpp: "priv_dumpLayerContentsC(@)",
                                    nodecl}

proc openSdfLayer(s: cstring): SdfLayerRefPtr {. importcpp: "SdfLayer::FindOrOpen(@)",
                                                 header: sdfLayerHeader .} 

proc getRealPath(l: SdfLayerRefPtr): cstring {. importcpp: "(char*)#->GetRealPath().c_str()",
                                                header: sdfLayerHeader .} 

proc getPsuedoroot(l: SdfLayerRefPtr): SdfPrimSpecHandle {. importcpp: "#->GetPseudoRoot()",
                                                            header: sdfPrimHeader .} 

proc getName(p: SdfPrimSpecHandle): cstring {. importcpp: "(char*)#->GetName().c_str()" 
                                               header: sdfPrimHeader .}

proc getName(p: SdfPropertySpecHandle): cstring {. importcpp: "(char*)#->GetName().c_str()" 
                                                   header: sdfPropertyHeader .}


proc `$`(p: SdfValueTypeName): cstring {. importcpp: "(char*)to_string(#).c_str()" .}

when isMainModule:
    var 
        l = openSdfLayer("./data/layer.sdf")
        path = $l.getRealPath()
        proot = l.getPsuedoroot()
        name = $proot.getName()
        rootPrims = l.getRootPrims()
        sdfInt = SdfValueTypeNameInt()
        sdfDouble = SdfValueTypeNameDouble()
        sdfHalf = SdfValueTypeNameHalf()
        sdfFloat = SdfValueTypeNameFloat()

    while not rootPrims.empty():
        var r = rootPrims.next()
        echo "root prim name: ", r.getName()

    echo "Opened layer at ", path, " with pseudoroot: ", name
