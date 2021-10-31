{.link: "<###>usd/build/inst/lib/libusd_ms.{!!!}".}

{.emit:"""
#include <pxr/pxr.h>
using namespace pxr;
""".}

const
    gfHalfHeader = "<###>usd/build/inst/include/pxr/base/gf/half.h"
    gfSize2Header = "<###>usd/build/inst/include/pxr/base/gf/size2.h"
    gfSize3Header = "<###>usd/build/inst/include/pxr/base/gf/size3.h"
    gfVec2iHeader = "<###>usd/build/inst/include/pxr/base/gf/vec2i.h"
    gfVec2fHeader = "<###>usd/build/inst/include/pxr/base/gf/vec2f.h"
    gfVec2dHeader = "<###>usd/build/inst/include/pxr/base/gf/vec2d.h"
    gfVec2hHeader = "<###>usd/build/inst/include/pxr/base/gf/vec2h.h"
    gfVec3iHeader = "<###>usd/build/inst/include/pxr/base/gf/vec3i.h"
    gfVec3fHeader = "<###>usd/build/inst/include/pxr/base/gf/vec3f.h"
    gfVec3dHeader = "<###>usd/build/inst/include/pxr/base/gf/vec3d.h"
    gfVec3hHeader = "<###>usd/build/inst/include/pxr/base/gf/vec3h.h"
    gfVec4iHeader = "<###>usd/build/inst/include/pxr/base/gf/vec4i.h"
    gfVec4fHeader = "<###>usd/build/inst/include/pxr/base/gf/vec4f.h"
    gfVec4dHeader = "<###>usd/build/inst/include/pxr/base/gf/vec4d.h"
    gfVec4hHeader = "<###>usd/build/inst/include/pxr/base/gf/vec4h.h"

type
    GfHalf {.header: gfHalfHeader,
             importcpp: "GfHalf".} = object

    GfSize2 {.header: gfSize2Header,
              importcpp: "GfSize2".} = object

    GfSize3 {.header: gfSize3Header,
              importcpp: "GfSize3".} = object

    GfVec2i {.header: gfVec2iHeader,
              importcpp: "GfVec2i".} = object

    GfVec2f {.header: gfVec2fHeader,
              importcpp: "GfVec2f".} = object

    GfVec2d {.header: gfVec2dHeader,
              importcpp: "GfVec2d".} = object

    GfVec2h {.header: gfVec2hHeader,
              importcpp: "GfVec2h".} = object

    GfVec3i {.header: gfVec3iHeader,
              importcpp: "GfVec3i".} = object

    GfVec3f {.header: gfVec3fHeader,
              importcpp: "GfVec3f".} = object

    GfVec3d {.header: gfVec3dHeader,
              importcpp: "GfVec3d".} = object

    GfVec3h {.header: gfVec3hHeader,
              importcpp: "GfVec3h".} = object

    GfVec4i {.header: gfVec4iHeader,
              importcpp: "GfVec4i".} = object

    GfVec4f {.header: gfVec4fHeader,
              importcpp: "GfVec4f".} = object

    GfVec4d {.header: gfVec4dHeader,
              importcpp: "GfVec4d".} = object

    GfVec4h {.header: gfVec4hHeader,
              importcpp: "GfVec4h".} = object


proc CreateGfHalf(): GfHalf {. header: gfHalfHeader,
                               importcpp: "GfHalf()" .}


proc CreateGfSize2(): GfSize2 {. header: gfSize2Header,
                                importcpp: "GfSize2()" .}

proc CreateGfSize3(): GfSize3 {. header: gfSize3Header,
                                 importcpp: "GfSize3()" .}


proc CreateGfVec2i(): GfVec2i {. header: gfVec2iHeader,
                                 importcpp: "GfVec2i()" .}


proc CreateGfVec2f(): GfVec2f {. header: gfVec2fHeader,
                                 importcpp: "GfVec2f()" .}


proc CreateGfVec2d(): GfVec2d {. header: gfVec2dHeader,
                                 importcpp: "GfVec2d()" .}


proc CreateGfVec2h(): GfVec2h {. header: gfVec2hHeader,
                                 importcpp: "GfVec2h()" .}


proc CreateGfVec3i(): GfVec3i {. header: gfVec3iHeader,
                                 importcpp: "GfVec3i()" .}


proc CreateGfVec3f(): GfVec3f {. header: gfVec3fHeader,
                                 importcpp: "GfVec3f()" .}


proc CreateGfVec3d(): GfVec3d {. header: gfVec3dHeader,
                                 importcpp: "GfVec3d()" .}


proc CreateGfVec3h(): GfVec3h {. header: gfVec3hHeader,
                                 importcpp: "GfVec3h()" .}

proc CreateGfVec4i(): GfVec4i {. header: gfVec4iHeader,
                                 importcpp: "GfVec4i()" .}


proc CreateGfVec4f(): GfVec4f {. header: gfVec4fHeader,
                                 importcpp: "GfVec4f()" .}


proc CreateGfVec4d(): GfVec4d {. header: gfVec4dHeader,
                                 importcpp: "GfVec4d()" .}


proc CreateGfVec4h(): GfVec4h {. header: gfVec4hHeader,
                                 importcpp: "GfVec4h()" .}

echo "Gf module"

var 
    s2 = CreateGfSize2()
    s3 = CreateGfSize3()
    v2i = CreateGfVec2i()
    v2f = CreateGfVec2f()
    v2d = CreateGfVec2d()
    v2h = CreateGfVec2h()
    v3i = CreateGfVec3i()
    v3f = CreateGfVec3f()
    v3d = CreateGfVec3d()
    v3h = CreateGfVec3h()
    v4i = CreateGfVec4i()
    v4f = CreateGfVec4f()
    v4d = CreateGfVec4d()
    v4h = CreateGfVec4h()

echo "Created types (size, vecs)"
