# Access Helsinki Linked Events API

Easy access to Helsinki Linked Events API

## Usage

``` r
get_linkedevents(query, ...)
```

## Source

Helsinki Linked Events API v1. Developed by the City of Helsinki Open
Software Development team. Event data from Helsinki Marketing, Helsinki
Cultural Centres, Helmet metropolitan area public libraries and City of
Helsinki registry of service unit. CC BY 4.0.
<https://creativecommons.org/licenses/by/4.0/>

For more API documentation and license information see the API link:
<http://api.hel.fi/linkedevents/v1/>

## Arguments

- query:

  The API query as a string, for example "event", "category",
  "language", "place" or "keyword".

- ...:

  Additional parameters that narrow down the output (optional).

## Value

Data frame or a list

## Details

Complete list of possible query input: "keyword", "keyword_set",
"place", "language", "organization", "image", "event", "search", "user".

With "..." the user can pass on additional parameters that depend on the
chosen query input. For example, when performing a search (query =
"search"), the search can be narrowed down with parameters such as:

- q="konsertti" complete search, returns events that have the word
  "konsertti"

- input="konse" partial search, returns events with words that contain
  "konse"

- type="event" returns only "events"

- start="2017-01-01" events starting on 2017-01-01 or after

- end="2017-01-10" events ending on 2017-01-10 or before

For more detailed explanation, see <http://api.hel.fi/linkedevents/v1/>.

## Author

Juuso Parkkinen <louhos@googlegroups.com>, Pyry Kantanen

## Examples

``` r
if (FALSE) { # \dontrun{
events <- get_linkedevents(query = "search", q = "teatteri", start = "2020-01-01")
} # }
```
