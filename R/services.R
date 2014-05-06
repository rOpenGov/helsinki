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
#' @examples # event.categories <- get_Omakaupunki_data("event/categories", LOGIN, PASSWORD, API)

get_Omakaupunki_data <- function(query, login, password, api_key, ...) {
  
  api.url <- "http://api.omakaupunki.fi/v1/"
  query.url <- paste0(api.url, query)
  curl <- RCurl::getCurlHandle(cookiefile = "")
  params <- list(login=login, password=password, api_key=api_key, ...)
  # Note! .checkParams=FALSE because 'password' given
  res.json <- RCurl::getForm(query.url, .params=params, curl=curl, binary=FALSE, .checkParams=FALSE)
  res.list <- rjson::fromJSON(res.json)
  return(res.list)
}

#' Access Paakaupunkiseudun Palvelukartta data
#'
#' Access Paakaupunkiseudun Palvelukartta data from the it's API (version 2). 
#' Using the API is free. For more details and API documentation see
#' http://www.hel.fi/palvelukarttaws/rest/ver2.html.
#' For licensing terms pf the data see http://www.hel2.fi/palvelukartta/REST.html.
#' 
#' @param category API query category, e.g. "service"
#' @param ... Additional parameters to the API (optional). See details from the API documentation
#'
#' @return List of results
#' @export
#' @importFrom RCurl getCurlHandle
#' @importFrom RCurl getForm
#' @importFrom rjson fromJSON
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples pk.services <- get_ServiceMap_data("service")
get_ServiceMap_data <- function(category, ...) {
      
  api.url <- "http://www.hel.fi/palvelukarttaws/rest/v2/"
  query.url <- paste0(api.url, category, "/")
  curl <- RCurl::getCurlHandle(cookiefile = "")
  # Note! Warnings suppressed because getForm outputs warning when no parameters (...) given
  suppressWarnings(
  res.json <- RCurl::getForm(uri=query.url, ..., curl=curl)
  )
  res.list <- rjson::fromJSON(res.json)
  return(res.list)
}
