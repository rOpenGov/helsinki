# Print all available Features

Basically a neat wrapper for "request=GetCapabilities".

## Usage

``` r
get_feature_list(base.url = NULL, queries = c(request = "GetCapabilities"))
```

## Arguments

- base.url:

  WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"

- queries:

  desired query for acquiring the list of features, default is
  "request=GetCapabilities"

## Value

data frame

## Details

Lists all `<FeatureType>` nodes.

## See also

Use
[`get_feature()`](https://ropengov.github.io/helsinki/reference/get_feature.md)
to download feature,
[`select_feature()`](https://ropengov.github.io/helsinki/reference/select_feature.md)
for menu-driven listing and downloading

## Author

Pyry Kantanen <pyry.kantanen@gmail.com>

## Examples

``` r
if (FALSE) { # \dontrun{
dat <- get_feature_list(base.url = "https://kartta.hsy.fi/geoserver/wfs")
} # }
```
