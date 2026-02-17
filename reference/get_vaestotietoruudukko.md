# Produce an SF object: Vaestotietoruudukko

Produces an sf object for Väestötietoruudukko (population grid).

## Usage

``` r
get_vaestotietoruudukko(year = NULL)
```

## Arguments

- year:

  a single year as numeric between 1997-2003 and 2008:2021. If NULL
  (default), the function will return the latest available dataset.

## Value

sf object

## Details

Additional data not available here can be manually downloaded from HRI
website: <https://hri.fi/data/fi/dataset/vaestotietoruudukko>

Years 1997-2003 and 2008-2021 are tested to work at the time of
development. Datasets from years 2015-2021 are downloaded from HSY WFS
API and datasets for other years are downloaded as zip files from HRI
website. The format of the output might be a bit different between
datasets downloaded from the WFS API and datasets downloaded from HRI
website.

Additional years may be added in the future and older datasets may be
removed from the API. See package NEWS for more information.

The current datasets can be listed with
[`get_feature_list()`](https://ropengov.github.io/helsinki/reference/get_feature_list.md)
or
[`select_feature()`](https://ropengov.github.io/helsinki/reference/select_feature.md).

## Author

Pyry Kantanen <pyry.kantanen@gmail.com>

## Examples

``` r
if (FALSE) { # \dontrun{
pop_grid <- get_vaestotietoruudukko(year = 2021)
} # }
```
