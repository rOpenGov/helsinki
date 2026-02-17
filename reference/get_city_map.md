# Get city administrative regions

Sf object of city districts in the Helsinki Capital Region.

## Usage

``` r
get_city_map(city = NULL, level = NULL, ...)
```

## Source

Metropolitan area in districts:
<https://hri.fi/data/en_GB/dataset/seutukartta>

## Arguments

- city:

  The desired city. Valid options: *Helsinki*, *Espoo*, *Vantaa*,
  *Kauniainen*

- level:

  The desired administrative level. Valid options: *suurpiiri*,
  *tilastoalue*, *pienalue* and *aanestysalue*

- ...:

  For passing parameters to embedded functions, for example *timeout.s*
  (timeout in seconds) in the case of **gracefully_fail()** internal
  function

## Value

sf object

## Details

See
[`get_feature_list()`](https://ropengov.github.io/helsinki/reference/get_feature_list.md)
for a list of all available features

## Author

Pyry Kantanen <pyry.kantanen@gmail.com>

## Examples

``` r
if (FALSE) { # \dontrun{
map <- get_city_map(city = "helsinki", level = "suuralue")
} # }
```
