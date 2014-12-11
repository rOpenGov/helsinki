# REMOVED 11.12.2014 as the API does not exist anymore

#' Access Omakaupunki data
#'
#' Access Omakaupunki data through the API. Using the API requireds a password 
#' and an API key. For more details and API documentation see
#' http://blogit.hs.fi/hsnext/omakaupungin-meno-ja-palvelutiedot-avoimena-rajapintana
#' 
#' @param query API query, e.g. "event" or "directory" (services)
#' @param login Personal username (required)
#' @param password Personal password (required)
#' @param api_key Personal API key (required)
#' @param ... Additional parameters to the API (optional). See details from the API documentation
#' The data is licensed under CC BY-NC-SA 3.0. 
#'
#' @return List of results
#' @export
#' @importFrom RCurl getCurlHandle
#' @importFrom RCurl getForm
#' @importFrom rjson fromJSON
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples \donttest{ #event.categories <- get_omakaupunki("event/categories", 
#' LOGIN, PASSWORD, API) }

get_omakaupunki <- function(query, login, password, api_key, ...) {
  
  api.url <- "http://api.omakaupunki.fi/v1/"
  query.url <- paste0(api.url, query)
  curl <- RCurl::getCurlHandle(cookiefile = "")
  params <- list(login=login, password=password, api_key=api_key, ...)
  # Note! .checkParams=FALSE because 'password' given
  res.json <- RCurl::getForm(query.url, .params=params, curl=curl, binary=FALSE, .checkParams=FALSE)
  res.list <- rjson::fromJSON(res.json)
  return(res.list)
}
