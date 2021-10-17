{.link: "<###>usd/build/inst/lib/libtf.so".}

{.emit:"""
using namespace pxr;
""".}

const
    tf = "<###>usd/build/inst/include/pxr/base/tf/token.h"

type
    TfTokenObj {.header: tf,
                 importcpp: "TfToken".} = object
    TfToken = ptr TfTokenObj
    
proc CreateTfToken(): TfTokenObj {. header: tf, importcpp: "TfToken()" .}

echo "attempting to make a tf token"
var t = CreateTfToken()
echo "success"
