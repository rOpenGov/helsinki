# Helsinki Region Infoshare statistics API

Retrieves data from the Helsinki Region Infoshare (HRI) statistics API:
<http://dev.hel.fi/stats/>. Currently provides access to the
*aluesarjat* data: <https://stat.hel.fi/pxweb/fi/Aluesarjat/>.

## Usage

``` r
get_hri_stats(query = "", verbose = TRUE)
```

## Arguments

- query:

  A string, specifying the dataset to query

- verbose:

  logical. Should R report extra information on progress? Default is
  TRUE

## Value

multi-dimensional array

## Details

Current implementation is very simple. You can either get the list of
resources with query="", or query for a specific resources and retrieve
it in a three-dimensional array form.

## References

See citation("helsinki")

## See also

See <https://dev.hel.fi/apis/statistics/>dev.hel.fi website and
<http://dev.hel.fi/stats/>API documentation (in Finnish)

## Author

Juuso Parkkinen <louhos@googlegroups.com>

## Examples

``` r
if (FALSE) { # \dontrun{
stats_array <- get_hri_stats("aluesarjat_a03s_hki_vakiluku_aidinkieli")
} # }
```
