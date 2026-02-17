# Access Helsinki region Service Map API

Access the new Helsinki region Service Map (Paakaupunkiseudun
Palvelukartta, <https://palvelukartta.hel.fi/fi/>) data through the API:
<http://api.hel.fi/servicemap/v2/>. For more API documentation and
license information see the API link.

## Usage

``` r
get_servicemap(query, ...)
```

## Source

API contents: All content is available under CC BY 4.0, except where
otherwise stated. The City of Helsinki logo is a registered trademark.
The Helsinki Grotesk Typeface is a proprietary typeface licensed by
Camelot Typefaces. <https://creativecommons.org/licenses/by/4.0/>

API Location: <https://api.hel.fi/servicemap/v2/>

API documentation: <https://dev.hel.fi/apis/service-map-backend-api/>

## Arguments

- query:

  The API query as a string, for example *search*, *service*, or *unit*.
  For full list of available options and details, see
  <https://dev.hel.fi/apis/service-map-backend-api/>.

- ...:

  Additional parameters to the API (optional). For additional details,
  see <https://dev.hel.fi/apis/service-map-backend-api/>.

## Value

Data frame or a list

## Details

Complete list of possible query input:

- "unit" unit, or service point

- "service" category of service provided by a unit

- "organization" organization providing services

- "search" full text search for units, services and street addresses

- "accessibility" rule database for calculating accessibility scores

- "geography" spatial information, where services are located

With "..." the user can pass on additional parameters that depend on the
chosen query input. For example, when performing a search (query =
"search"), the search can be narrowed down with parameters such as:

- "q" complete search

- "input" partial search

- "type" valid types: service_node, service, unit, address

- "language" as two-character ISO-639-1 code: fi, sv, en

- "municipality" comma-separated list of municipalities, lower-case, in
  Finnish

- "service" comma-separated list of service IDs

- "include" include the complete content from certain fields with a
  comma-separated list of field names with a valid type prefix

- "only" restricts the results with a comma-separated list of field
  names with a valid type prefix

- "page" request a certain page number

- "page_size" determine number of entries in one page

For more detailed explanation, see
<https://dev.hel.fi/apis/service-map-backend-api/>.

## Author

Juuso Parkkinen <louhos@googlegroups.com>, Pyry Kantanen

## Examples

``` r
if (FALSE) { # \dontrun{
# A data.frame with 47 variables
search_puisto <- get_servicemap(query = "search", q = "puisto")
# A data.frame with 7 variables
search_padel <- get_servicemap(
  query = "search", input = "padel",
  only = "unit.name, unit.location.coordinates, unit.street_address",
  municipality = "helsinki"
)
} # }
```
