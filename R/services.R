# This file is a part of the helsinki package (http://github.com/rOpenGov/helsinki)
# in association with the rOpenGov project (http://ropengov.org)

# Copyright (C) 2010-2021 Juuso Parkkinen, Leo Lahti and Joona Lehtomaki / Louhos <louhos.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


#' @title Access Helsinki region Service Map API
#'
#' Access the new Helsinki region Service Map (Paakaupunkiseudun Palvelukartta)
#' http://dev.hel.fi/servicemap/ data through the API: http://api.hel.fi/servicemap/v2/. 
#' For more API documentation and license information see the API link.
#' 
#' @param query The API query as a string, for example "search", "service", or "unit".
#' For full list of available options and details, see http://api.hel.fi/servicemap/v2/. 
#' @param ... Additional parameters to the API (optional).
#' For details, see http://api.hel.fi/servicemap/v2/. 
#'
#' @return Data frame
#' 
#' @importFrom httr parse_url build_url
#' @importFrom jsonlite fromJSON
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}, Pyry Kantanen
#' @examples 
#' search.puisto <- get_servicemap(query="search", q="puisto")
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
  res_list <- res_list$data 
  return(res_list)
}



#' @title Access Helsinki Linked Events API
#'
#' Access the new Helsinki Linked Events API: http://api.hel.fi/linkedevents/v0.1/.
#' The API contains data from the Helsinki City Tourist & Convention Bureau, 
#' the City of Helsinki Cultural Office and the Helmet metropolitan area public libraries.
#' For more API documentation and license information see the API link.
#' 
#' @param query The API query as a string, one of "category", "event", "language", or "place".
#' For details, see http://api.hel.fi/linkedevents/v1/. 
#' @param ... Additional parameters to the API (optional).
#' For details, see http://api.hel.fi/linkedevents/v1/. 
#'
#' @return Data frame
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
  res_list <- res_list$data 
  return(res_list)
}
