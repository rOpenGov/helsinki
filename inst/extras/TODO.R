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