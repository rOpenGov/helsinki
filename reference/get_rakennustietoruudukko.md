# Produce an SF object: Rakennustietoruudukko

Produces an sf object for Rakennustietoruudukko (building information
grid).

## Usage

``` r
get_rakennustietoruudukko(year = NULL)
```

## Arguments

- year:

  year as numeric between 1997-1998 and 2009-2021. If NULL (default),
  the function will return the latest available dataset.

## Value

sf object

## Details

Additional data not available here can be manually downloaded from HRI
website: <https://hri.fi/data/fi/dataset/rakennustietoruudukko>

Years 2015-2021 are tested to work at the time of development.
Additional years may be added in the future and older datasets may be
removed from the API. Datasets from years 2015-2021 are downloaded from
HSY WFS API and datasets for other years are downloaded as zip files
from HRI website. The format of the output might be a bit different
between datasets downloaded from the WFS API and datasets downloaded
from HRI website.

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
building_grid <- get_rakennustietoruudukko(year = 2021)
} # }
```
