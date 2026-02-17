# WFS API

Requests to various WFS API.

## Usage

``` r
wfs_api(base.url = NULL, queries, ...)
```

## Source

Gracefully failing HTTP request code (slightly adapted by Pyry Kantanen)
from RStudio community member kvasilopoulos. Many thanks!

Source of the original RStudio community discussion:
<https://community.rstudio.com/t/internet-resources-should-fail-gracefully/49199>

## Arguments

- base.url:

  WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"

- queries:

  List of query parameters

- ...:

  For passing parameters to embedded functions, for example *timeout.s*
  (timeout in seconds) in the case of **gracefully_fail()** internal
  function

## Value

wfs_api (S3) object with the following attributes:

- content:

  XML payload.

- path:

  path provided to get the resonse.

- response:

  the original response object.

## Details

Make a request to the spesific WFS API. The base url is
https://kartta.hsy.fi/geoserver/wfs to which other components defined by
the arguments are appended.

This is a low-level function intended to be used by other higher level
functions in the package.

## Author

Joona Lehtomäki <joona.lehtomaki@iki.fi>, Kostas Vasilopoulos, Pyry
Kantanen

## Examples

``` r
if (FALSE) { # \dontrun{
wfs_api(
  base.url = "https://kartta.hsy.fi/geoserver/wfs",
  queries = c(
    "service" = "WFS",
    "version" = "1.0.0",
    "request" = "getFeature",
    "typeName" = "ilmanlaatu:Ilmanlaatu_nyt"
  )
)
} # }
```
