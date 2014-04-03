
#' Retrieve address information in Helsinki region 
#'
#' Retrieves address data from Helsinki 
#' Real Estate Department (Helsingin 
#' kaupungin kiinteistovirasto, HKK):
#' http://kartta.hel.fi/avoindata/index.html
#'
#' The data (C) 2011 Helsingin kaupunkimittausosasto.
#' 
#' @param which.data  A string. Specify the name of the HKK data set to retrieve. Options: "Helsingin osoiteluettelo", "Seudullinen osoiteluettelo"
#' @param data.dir Directory where the original downloaded raw data will be stored.
#'
#' @return List with the following elements: local.file (local file name); local.path (download directory); source.url (url of the original data file); time (date and time of data download); which.data (data set to retrieve)
#' @export
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @references See citation("helsinki") 
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # tab <- get_helsinki_address_info("Helsingin osoiteluettelo")

get_HKK_address_data <- function(which.data, data.dir=tempdir()) {
    
  # Create data.dir if it does not exist
  if (!file.exists(data.dir))
    dir.create(data.dir)
  
  # Define files based on chosen data
  if (which.data == "Seudullinen osoiteluettelo") {
    
    # Seudullinen osoiteluettelo
    # http://kartta.hel.fi/avoindata/aineistot/Seudullinen_osoiteluettelo.zip
    zipfile <- "Seudullinen_osoiteluettelo.zip"
    res.file <- "Seudullinen_osoiteluettelo.csv"
    pdf.url <- "http://ptp.hel.fi/avoindata/aineistot/Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"
    
  } else if (which.data == "Helsingin osoiteluettelo") {
    
    # Helsingin osoiteluettelo
    # http://kartta.hel.fi/avoindata/aineistot/Helsingin_osoiteluettelo.zip
    zipfile <- "Helsingin_osoiteluettelo.zip"
    res.file <- "Helsingin_osoiteluettelo.csv"
    pdf.url <- "http://ptp.hel.fi/avoindata/aineistot/Avoimen_osoitetiedon_kuvaus.pdf"
  }
  
  # Download the data
  remote.zip <- paste("http://kartta.hel.fi/avoindata/aineistot/", zipfile, sep = "")
  local.zip <- file.path(data.dir, zipfile)
  message(paste("Dowloading", remote.zip, "\ninto", local.zip))
  utils::download.file(remote.zip, destfile = local.zip)
  
  # Unzip the downloaded zip file
  utils::unzip(local.zip, exdir = data.dir)
  
  message(paste("For detailed description of", which.data, "data, see description PDF file:", pdf.url))
  
  # Read data
  tab <- read.csv(file.path(data.dir, res.file), fileEncoding = "ISO-8859-1")
  
  message("\nData loaded successfully")
  return(tab)
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



## THE IS TO BE DELETED
# #' Retrieve address information in Helsinki region 
# #'
# #' Retrieves address data from Helsinki 
# #' Real Estate Department (Helsingin 
# #' kaupungin kiinteistovirasto, HKK):
# #' http://kartta.hel.fi/avoindata/index.html
# #'
# #' The data (C) 2011 Helsingin kaupunkimittausosasto.
# #' 
# #' @param which.data  A string. Specify the name of the HKK data set to retrieve. Options: "Helsingin osoiteluettelo", "Seudullinen osoiteluettelo"
# #' @param data.dir Directory where the original downloaded raw data will be stored.
# #'
# #' @return List with the following elements: local.file (local file name); local.path (download directory); source.url (url of the original data file); time (date and time of data download); which.data (data set to retrieve)
# #' @export
# #' @references
# #' See citation("helsinki") 
# #' @author Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
# #' @examples # tab <- GetAddressInfo("Helsingin osoiteluettelo")
# 
# DownloadAddressInfo <- function( which.data, data.dir = NULL ) {
#   
#   if (is.null(data.dir)) {data.dir <- tempdir()}
# 
#   if (which.data == "Seudullinen osoiteluettelo") {
# 
#     # Seudullinen osoiteluettelo
#     # http://kartta.hel.fi/avoindata/aineistot/Seudullinen_osoiteluettelo.zip
#     zipfile <- "Seudullinen_osoiteluettelo.zip"
#     remote.zip <- paste("http://kartta.hel.fi/avoindata/aineistot/", zipfile, sep = "")
#     local.zip <- file.path(data.dir, zipfile)
# 
#     # Create the web address from where to fetch the zip
#     message(paste("Dowloading data from ", remote.zip, "in file", local.zip))
#     download.file(remote.zip, destfile = local.zip)
# 
#     # Unzip the downloaded zip file
#     unzip(local.zip, exdir = data.dir)
# 
#     # "Seudullinen_osoiteluettelo.csv"             
#     # "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"
# 
#     message(paste("For detailed description of Seudullinen osoiteluettelo data, see description PDF file", file.path(data.dir, "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"), "downloaded from", remote.zip))
# 
#     f <- file.path(data.dir, "Seudullinen_osoiteluettelo.csv")
# 
#   } else if (which.data == "Helsingin osoiteluettelo") {
# 
#     # Helsingin osoiteluettelo
#     # http://kartta.hel.fi/avoindata/aineistot/Helsingin_osoiteluettelo.zip
#     zipfile <- "Helsingin_osoiteluettelo.zip"
#     remote.zip <- paste("http://kartta.hel.fi/avoindata/aineistot/", zipfile, sep = "")
#     local.zip <- file.path(data.dir, zipfile)
# 
#     # Create the web address from where to fetch the zip
#     message(paste("Dowloading data from ", remote.zip, "in file", local.zip))
#     download.file(remote.zip, destfile = local.zip)
# 
#     # Unzip the downloaded zip file
#     unzip(local.zip, exdir = data.dir)
# 
#     # "Helsingin_osoiteluettelo.csv"             
#     # "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"
# 
#     message(paste("For detailed description of Helsingin osoiteluettelo data, see description PDF file", file.path(data.dir, "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"), "downloaded from", remote.zip))
# 
#     f <- file.path(data.dir, "Helsingin_osoiteluettelo.csv")
# 
#   }
# 
#   # Remove temporary directory
# #  unlink(data.dir, recursive=T)
# 
#   list(local.file = f, local.path = data.dir, source.url = remote.zip, time = date(), which.data = which.data)
# 
# }
# 
# 
# #' Retrieve address information in Helsinki region 
# #'
# #' Retrieves address data from Helsinki 
# #' Real Estate Department (Helsingin 
# #' kaupungin kiinteistovirasto, HKK):
# #' http://kartta.hel.fi/avoindata/index.html
# #'
# #' The data (C) 2011 Helsingin kaupunkimittausosasto.
# #' 
# #' @param local.file  A filename pointing to the downloaded data, either "Helsingin osoiteluettelo" or "Seudullinen osoiteluettelo"
# #'
# #' @return data frame
# #' @export
# #' @references
# #' See citation("helsinki") 
# #' @author Leo Lahti \email{louhos@@googlegroups.com}
# #' @examples # res <- DownloadAddressInfo("Helsingin osoiteluettelo"); dat <- GetAddressInfo( res$local.file )
# 
# GetAddressInfo <- function( local.file ) {
#   
#   # "Seudullinen_osoiteluettelo.csv"             
#   # "Helsingin_osoiteluettelo.csv"             
#   # "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"
# 
#   s <- strsplit(local.file, "/")
#   message(paste("For data licensing and other information, see ", s[[length(s)]], "/Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf", sep = ""))
# 
#   tab <- read.csv(local.file, fileEncoding = "ISO-8859-1")
#   return(tab)
# 
# }


