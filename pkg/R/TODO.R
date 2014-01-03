
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
#'
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples # event.categories <- GetOmakaupunki("event/categories", LOGIN, PASSWORD, API)
GetOmakaupunki <- function(query, login, password, api_key, ...) {
  
  .InstallMarginal("RCurl")
  .InstallMarginal("rjson")

  api.url <- "http://api.omakaupunki.fi/v1/"
  query.url <- paste(api.url, query, sep="")
  curl <- RCurl::getCurlHandle(cookiefile = "")
  params <- list(login=login, password=password, api_key=api_key, ...)
  val <- RCurl::getForm(query.url, .params=params, curl=curl, binary=FALSE)
  res <- rjson::fromJSON(val)
  return(res)
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
#'
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples # pk.services <- GetPalvelukartta("service")

GetPalvelukartta <- function(category, ...) {
  
  api.url <- paste("http://www.hel.fi/palvelukarttaws/rest/v2/", category, "/", sep="")
  curl <- RCurl::getCurlHandle(cookiefile = "")
  params <- list(...)
  val <- RCurl::getForm(api.url, .params=params, curl=curl)
  res <- rjson::fromJSON(val)
  return(res)
}


#' Retrieve HKK data: Helsingin kaupungin rakennusrekisterin ote 
#'
#' Retrieves data from Helsinki Real Estate Department (Helsingin 
#' kaupungin kiinteistovirasto, HKK) through the HKK website
#' http://kartta.hel.fi/avoindata/index.html
#'
#' The data (C) 2011 Helsingin kaupunkimittausosasto.
#' 
#' @param which.data  A string. Specify the name of the data set to retrieve. 
#'
#' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
#' @importFrom rgdal readOGR
#' @importFrom rgdal ogrListLayers
#' @references
#' See citation("helsinki") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # tab <- GetHKK("Helsingin osoiteluettelo")

GetHelsinkiBuildingRegistry <- function( which.data ) {

  # TODO did not manage to read the mapinfo files in R with rgdal.
  # Check how to do, implement and export 
  # Also note the metadata Excel that is available  

  data.url <- "http://kartta.hel.fi/avoindata/aineistot/"
  data.dir <- tempdir()  

  # Helsingin kaupungin rakennusrekisterin ote:
  # http://kartta.hel.fi/avoindata/aineistot/rakennukset_Helsinki_06_2012.zip

  remote.zip <- "rakennukset_Helsinki_06_2012.zip"
  unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

  # "Metatieto_rakennukset.xls"
  # "rakennukset_helsinki_20m2_hkikoord" 
  # "rakennukset_Helsinki_etrsgk25"     
  # "rakennukset_Helsinki_hkikoord"      
  # "rakennukset_Helsinki_wgs84"        

  # Facta-kenttien metatiedot_.pdf          
  # rakennukset_Helsinki_06_2012_wgs84.DAT 

  # Read the specified map	       
  f <- file.path(data.dir, paste("rakennukset_Helsinki_wgs84/", "rakennukset_Helsinki_06_2012_wgs84.DAT", sep = ""))

  # Shape file or list of shape files; one for each layer
  sp <- readmap(f)

  # Remove temporary directory
  unlink(data.dir, recursive=T)

  return(sp)

  stop(paste(which.data, "not implemented"))

}

