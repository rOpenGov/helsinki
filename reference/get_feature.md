# Produce an SF object

Produces an sf object for easy visualization

## Usage

``` r
get_feature(
  base.url = "https://kartta.hsy.fi/geoserver/wfs",
  typename = "asuminen_ja_maankaytto:Vaestotietoruudukko_2015",
  CRS = 3879
)
```

## Arguments

- base.url:

  WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"

- typename:

  accepts feature names, e.g.
  "asuminen_ja_maankaytto:1000m_verkostobufferi" No short form titles
  here, e.g. "1000m_verkostobufferi"!

- CRS:

  Default CRS is 3879 (or EPSG:3879), see ?sf::st_crs for other input
  options

## Value

sf object

## See also

Use
[`get_feature_list`](https://ropengov.github.io/helsinki/reference/get_feature_list.md)
to list all available features for a given WFS,
[`select_feature`](https://ropengov.github.io/helsinki/reference/select_feature.md)
for listing and selecting a feature

## Author

Pyry Kantanen <pyry.kantanen@gmail.com>
