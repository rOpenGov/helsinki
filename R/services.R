#' @title Access Helsinki region Service Map API
#'
#' @description Access the new Helsinki region Service Map (Paakaupunkiseudun Palvelukartta)
#' https://palvelukartta.hel.fi/fi/ data through the API: http://api.hel.fi/servicemap/v2/. 
#' For more API documentation and license information see the API link.
#' 
#' @param query The API query as a string, for example "search", "service", or "unit".
#' For full list of available options and details, see https://dev.hel.fi/apis/service-map-backend-api/. 
#' @param ... Additional parameters to the API (optional). 
#' For additional details, see https://dev.hel.fi/apis/service-map-backend-api/. 
#'
#' @details 
#' Complete list of possible query input: 
#' \itemize{
#'  \item{"unit"} {unit, or service point}
#'  \item{"service"} {category of service provided by a unit}
#'  \item{"organization"} {organization providing services}
#'  \item{"search"} {full text search for units, services and street addresses}
#'  \item{"accessibility"} {rule database for calculating accessibility scores} 
#'  \item{"geography"} {spatial information, where services are located}
#'  }
#' 
#' With "..." the user can pass on additional parameters that depend on the
#' chosen query input. For example, when performing a search (query = "search"), 
#' the search can be narrowed down with parameters such as:
#' \itemize{
#'  \item{"q"} {complete search}
#'  \item{"input"} {partial search}
#'  \item{"type"} {valid types: service_node, service, unit, address}
#'  \item{"language"} {as two-character ISO-639-1 code: fi, sv, en}
#'  \item{"municipality"} {comma-separated list of municipalities, lower-case, in Finnish}
#'  \item{"service"} {comma-separated list of service IDs}
#'  \item{"include"} {include the complete content from certain fields with a comma-separated list of field names  with a valid type prefix}
#'  \item{"only"} {restricts the results with a comma-separated list of field names with a valid type prefix}
#'  \item{"page"} {request a certain page number}
#'  \item{"page_size"} {determine number of entries in one page}
#' }
#' 
#' For more detailed explanation, see https://dev.hel.fi/apis/service-map-backend-api/. 
#'
#' @return Data frame or a list
#' 
#' @importFrom httr parse_url build_url
#' @importFrom jsonlite fromJSON
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}, Pyry Kantanen
#' @examples 
#' # A data.frame with 47 variables
#' search_puisto <- get_servicemap(query="search", q="puisto")
#' # A data.frame with 7 variables
#' search_padel <- get_servicemap(query="search", input="padel", 
#' only="unit.name, unit.location.coordinates, unit.street_address", 
#' municipality="helsinki")
#' 
#' @source API contents: All content is available under CC BY 4.0, 
#' except where otherwise stated. The City of Helsinki logo is a registered 
#' trademark. The Helsinki Grotesk Typeface is a proprietary typeface licensed 
#' by Camelot Typefaces.
#' <https://creativecommons.org/licenses/by/4.0/>
#' 
#' API Location: https://api.hel.fi/servicemap/v2/
#' 
#' API documentation: https://dev.hel.fi/apis/service-map-backend-api/
#' 
#' @export

get_servicemap <- function(query, ...) {
  
  api_url <- "http://api.hel.fi/servicemap/v2/"
  query_url <- paste0(api_url, query, "/")
  
  url <- httr::parse_url(query_url)
  url$query <- list(...)
  url <- httr::build_url(url)
  
  # Check whether API url available
  conn<-url(api_url)
  doesnotexist<-inherits(try(suppressWarnings(readLines(conn)),silent=TRUE),"try-error")
  close(conn)
  if (doesnotexist) {
    warning(paste("Sorry! API", api_url, "not available! Returning NULL"))
    return(NULL)
  }

  res_list <- jsonlite::fromJSON(url)
  # res_list <- res_list$results 
  
  message(
"All content is available under CC BY 4.0, except where otherwise stated. 
The City of Helsinki logo is a registered trademark. The Helsinki Grotesk 
Typeface is a proprietary typeface licensed by Camelot Typefaces. 
CC BY 4.0: <https://creativecommons.org/licenses/by/4.0/>")
  
  return(res_list)
}



#' @title Access Helsinki Linked Events API
#'
#' @description Easy access to Helsinki Linked Events API
#' 
#' @source Helsinki Linked Events API v1. Developed by the City of Helsinki 
#' Open Software Development team. Event data from Helsinki Marketing, Helsinki 
#' Cultural Centres, Helmet metropolitan area public libraries and City of 
#' Helsinki registry of service unit. 
#' CC BY 4.0. <https://creativecommons.org/licenses/by/4.0/>
#' 
#' For more API documentation and license information see the API link:
#' http://api.hel.fi/linkedevents/v1/
#' 
#' @param query The API query as a string, for example "event", "category",
#' "language", "place" or "keyword". 
#' @param ... Additional parameters that narrow down the output (optional). 
#'
#' @details 
#' Complete list of possible query input: "keyword", "keyword_set", "place",
#' "language", "organization", "image", "event", "search", "user".
#' 
#' With "..." the user can pass on additional parameters that depend on the
#' chosen query input. For example, when performing a search (query = "search"), 
#' the search can be narrowed down with parameters such as:
#' \itemize{
#'  \item{q="konsertti"} {complete search, returns events that have the word "konsertti"}
#'  \item{input="konse"} {partial search, returns events with words that contain "konse"}
#'  \item{type="event"} {returns only "events"}
#'  \item{start="2017-01-01"} {events starting on 2017-01-01 or after}
#'  \item{end="2017-01-10"} {events ending on 2017-01-10 or before}
#' }
#' 
#' For more detailed explanation, see http://api.hel.fi/linkedevents/v1/. 
#'
#' @return Data frame or a list
#' 
#' @importFrom httr parse_url build_url
#' @importFrom jsonlite fromJSON
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}, Pyry Kantanen
#' 
#' @examples 
#' events <- get_linkedevents(query="search", q="teatteri", start="2020-01-01")
#' 
#' @export

get_linkedevents <- function(query, ...) {
  
  # Build query url
  api_url <- "http://api.hel.fi/linkedevents/v1/"
  query_url <- paste0(api_url, query, "/")
  
  url <- httr::parse_url(query_url)
  url$query <- list(...)
  url <- httr::build_url(url)
  
  # Check whether API url available
  conn<-url(api_url)
  doesnotexist<-inherits(try(suppressWarnings(readLines(conn)),silent=TRUE),"try-error")
  close(conn)
  if (doesnotexist) {
    warning(paste("Sorry! API", api_url, "not available! Returning NULL"))
    return(NULL)
  }

  res_list <- jsonlite::fromJSON(url)
  # res_list <- res_list$data 
  
  message(
  "Source: Helsinki Linked Events API v1. Developed by the City of Helsinki 
  Open Software Development team. Event data from Helsinki Marketing,
  Helsinki Cultural Centres, Helmet metropolitan area public libraries and
  City of Helsinki registry of service unit. 
  CC BY 4.0: <https://creativecommons.org/licenses/by/4.0/>")
  
  return(res_list)
}
