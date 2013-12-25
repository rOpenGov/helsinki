unzip.files <- function (data.dir, remote.zip, local.zip, data.url, which.data) {

    # Local zip location 
    local.zip <- file.path(data.dir, remote.zip)

    # Create the web address from where to fetch the zip
    data.url <- paste(data.url, remote.zip, sep = "")
    message(paste("Dowloading HKK", which.data, " data from ", data.url, "in file", local.zip, ". Kindly cite the original data sources. For license and citation information, see http://kartta.hel.fi/avoindata/"))
    download.file(data.url, destfile = local.zip)

    # Unzip the downloaded zip file
    #data.dir <- file.path(data.dir, "aanestysalueet")
    unzip(local.zip, exdir = data.dir)

}

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
#' @references
#' See citation("helsinki") 
#' @author Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # tab <- GetAddressInfo("Helsingin osoiteluettelo")

DownloadAddressInfo <- function( which.data, data.dir = NULL ) {
  
  if (is.null(data.dir)) {data.dir <- tempdir()}

  if (which.data == "Seudullinen osoiteluettelo") {

    # Seudullinen osoiteluettelo
    # http://kartta.hel.fi/avoindata/aineistot/Seudullinen_osoiteluettelo.zip
    zipfile <- "Seudullinen_osoiteluettelo.zip"
    remote.zip <- paste("http://kartta.hel.fi/avoindata/aineistot/", zipfile, sep = "")
    local.zip <- file.path(data.dir, zipfile)

    # Create the web address from where to fetch the zip
    message(paste("Dowloading data from ", remote.zip, "in file", local.zip))
    download.file(remote.zip, destfile = local.zip)

    # Unzip the downloaded zip file
    unzip(local.zip, exdir = data.dir)

    # "Seudullinen_osoiteluettelo.csv"             
    # "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"

    message(paste("For detailed description of Seudullinen osoiteluettelo data, see description PDF file", file.path(data.dir, "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"), "downloaded from", remote.zip))

    f <- file.path(data.dir, "Seudullinen_osoiteluettelo.csv")

  } else if (which.data == "Helsingin osoiteluettelo") {

    # Helsingin osoiteluettelo
    # http://kartta.hel.fi/avoindata/aineistot/Helsingin_osoiteluettelo.zip
    zipfile <- "Helsingin_osoiteluettelo.zip"
    remote.zip <- paste("http://kartta.hel.fi/avoindata/aineistot/", zipfile, sep = "")
    local.zip <- file.path(data.dir, zipfile)

    # Create the web address from where to fetch the zip
    message(paste("Dowloading data from ", remote.zip, "in file", local.zip))
    download.file(remote.zip, destfile = local.zip)

    # Unzip the downloaded zip file
    unzip(local.zip, exdir = data.dir)

    # "Helsingin_osoiteluettelo.csv"             
    # "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"

    message(paste("For detailed description of Helsingin osoiteluettelo data, see description PDF file", file.path(data.dir, "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"), "downloaded from", remote.zip))

    f <- file.path(data.dir, "Helsingin_osoiteluettelo.csv")

  }

  # Remove temporary directory
  unlink(data.dir, recursive=T)

  list(local.file = f, local.path = data.dir, source.url = remote.zip, time = date(), which.data = which.data)

}


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
#'
#' @return data frame
#' @export
#' @references
#' See citation("helsinki") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # res <- DownloadAddressInfo("Helsingin osoiteluettelo"); dat <- GetAddressInfo( res$local.file )

GetAddressInfo <- function( local.file ) {
  
  # "Seudullinen_osoiteluettelo.csv"             
  # "Helsingin_osoiteluettelo.csv"             
  # "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"

  s <- strsplit(local.file, "/")
  message(paste("For data licensing and other information, see ", s[[length(s)]], "/Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf", sep = ""))

  tab <- read.csv(local.file, fileEncoding = "ISO-8859-1")
  return(tab)

}


