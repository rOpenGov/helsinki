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
#' For full list of available options and details, see https://dev.hel.fi/apis/service-map-backend-api. 
#' @param ... Additional parameters to the API (optional). 
#' For additional details, see https://dev.hel.fi/apis/service-map-backend-api. 
#'
#' @return Data frame or a list
#' 
#' @importFrom httr parse_url build_url
#' @importFrom jsonlite fromJSON
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}, Pyry Kantanen
#' @examples 
#' search.puisto <- get_servicemap(query="search", q="puisto")
#' 
#' @source API contents: All content is available under CC BY 4.0, 
#' except where otherwise stated. The City of Helsinki logo is a registered 
#' trademark. The Helsinki Grotesk Typeface is a proprietary typeface licensed 
#' by Camelot Typefaces.
#' <https://creativecommons.org/licenses/by/4.0/>
#' API Location: https://api.hel.fi/servicemap/v2/
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
  # the element might not always be called data, making this dangerous
  # res_list <- res_list$data 
  
  message("All content is available under CC BY 4.0, except where otherwise 
  stated. The City of Helsinki logo is a registered trademark. The Helsinki 
  Grotesk Typeface is a proprietary typeface licensed by Camelot Typefaces. 
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
#'  \item{q="konsertti"} {searches for events that have the word "konsertti" on them}
#'  \item{input="konse"} {searches also for substrings inside words}
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
  # the element might not always be called data, making this dangerous
  # res_list <- res_list$data 
  message("Source: Helsinki Linked Events API v1. Developed by the City of
  Helsinki Open Software Development team. Event data from Helsinki Marketing,
  Helsinki Cultural Centres, Helmet metropolitan area public libraries and
  City of Helsinki registry of service unit. 
  CC BY 4.0: <https://creativecommons.org/licenses/by/4.0/>")
  
  return(res_list)
}
