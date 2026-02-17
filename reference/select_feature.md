# Interactively browse and select features

Use an interactive menu to select and download a feature for use in
other functions

## Usage

``` r
select_feature(base.url = NULL, get = FALSE)
```

## Arguments

- base.url:

  WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"

- get:

  Should the selected feature be downloaded? Default is `FALSE`

## Value

feature Title (character) or feature object (sf), if `get` parameter is
TRUE

## See also

[`get_feature`](https://ropengov.github.io/helsinki/reference/get_feature.md),
[`get_feature_list`](https://ropengov.github.io/helsinki/reference/get_feature_list.md)

## Author

Pyry Kantanen <pyry.kantanen@gmail.com>

## Examples

``` r
if (FALSE) { # \dontrun{
selection <- select_feature(base.url = "https://kartta.hsy.fi/geoserver/wfs")
feature <- get_feature(base.url = "https://kartta.hsy.fi/geoserver/wfs", type_name = selected)
ggplot(feature) +
  geom_sf()
} # }
```
