# This file is a part of the helsinki package (http://github.com/rOpenGov/helsinki)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2010-2014 Juuso Parkkinen, Leo Lahti and Joona Lehtomäki / Louhos <louhos.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


#' Access Helsinki region Service Map API
#'
#' Access the new Helsinki region Service Map (Paakaupunkiseudun Palvelukartta)
#' http://dev.hel.fi/servicemap/ data through the API: http://api.hel.fi/servicemap/v1/. 
#' For more API documentation and license information see the API link.
#' 
#' @param A string. The API query, for example "search", "service", or "unit".
#' For full list of available options and details, see http://api.hel.fi/servicemap/v1/. 
#' @param ... Additional parameters to the API (optional).
#' For details, see http://api.hel.fi/servicemap/v1/. 
#'
#' @return List of results
#' @export
#' @importFrom RCurl getCurlHandle
#' @importFrom RCurl getForm
#' @importFrom rjson fromJSON
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples \donttest{ search.puisto <- get_servicemap(category="search", q="puisto") }

get_servicemap <- function(category, ...) {
  
  # api.url <- "http://www.hel.fi/palvelukarttaws/rest/v2/"
  # Define query url
  # New API (13.5.2014)
  api.url <- "http://api.hel.fi/servicemap/v1/"
  query.url <- paste0(api.url, category, "/")
  
  # Get Curl handle
  curl <- RCurl::getCurlHandle(cookiefile = "")
  
  # Get data as json using getForm
  # Note! Warnings suppressed because getForm outputs warning when no parameters (...) given
  suppressWarnings(
    res.json <- RCurl::getForm(uri=query.url, ..., curl=curl)
  )
  # Transform results into list from JSON
  res.list <- rjson::fromJSON(res.json)
  return(res.list)
}



#' Access Helsinki Linked Events API
#'
#' Access the new Helsinki Linked Events API: http://api.hel.fi/linkedevents/v0.1/.
#' The API contains data from the Helsinki City Tourist & Convention Bureau, 
#' the City of Helsinki Cultural Office and the Helmet metropolitan area public libraries.
#' For more API documentation and license information see the API link.
#' 
#' @param A string. The API query, one of "category", "event", "language", or "place".
#' For details, see http://api.hel.fi/linkedevents/v0.1/. 
#' @param ... Additional parameters to the API (optional).
#' For details, see http://api.hel.fi/linkedevents/v0.1/. 
#'
#' @return List of results
#' @export
#' @importFrom RCurl getCurlHandle
#' @importFrom RCurl getForm
#' @importFrom rjson fromJSON
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples \donttest{ events <- get_linkedevents("event") }

get_linkedevents <- function(category, ...) {
  
  # Define query url
  api.url <- "http://api.hel.fi/linkedevents/v0.1/"
  query.url <- paste0(api.url, category, "/")
  
  # Get Curl handle
  curl <- RCurl::getCurlHandle(cookiefile = "")
  
  # Get data as json using getForm
  # Note! Warnings suppressed because getForm outputs warning when no parameters (...) given
  suppressWarnings(
    res.json <- RCurl::getForm(uri=query.url, ..., curl=curl)
  )
  # Transform results into list from JSON
  res.list <- rjson::fromJSON(res.json)
  return(res.list)
}


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

