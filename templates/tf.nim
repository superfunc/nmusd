{.link: "<###>lib/libusd_ms.{!!!}".}

{.emit:"""
#include <pxr/pxr.h>
using namespace pxr;
""".}

const
    tf = "<###>include/pxr/base/tf/token.h"

type
    TfTokenObj {.header: tf,
                 importcpp: "TfToken".} = object
    TfToken = ptr TfTokenObj
    
proc CreateTfToken(): TfTokenObj {. header: tf, importcpp: "TfToken()" .}

when isMainModule():
    echo "Tf Module"
    
    echo "attempting to make a tf token"
    var t = CreateTfToken()
    echo "success"
