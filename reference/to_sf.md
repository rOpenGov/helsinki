# Transform to sf-object

Transform a wfs_api object into a sf object.

## Usage

``` r
to_sf(api_obj)
```

## Arguments

- api_obj:

  wfs api object

## Value

sf object

## Details

FMI API response object's XML (GML) content is temporarily wrtitten on
disk and then immediately read back in into a sf object.

## Note

For internal use, not exported.

## Author

Joona Lehtomäki <joona.lehtomaki@iki.fi>
