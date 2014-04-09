
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
#' @return A data frame containing the address data
#' @export
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @references See citation("helsinki") 
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # tab <- get_helsinki_address_info("Helsingin osoiteluettelo")

get_HKK_address_data <- function(which.data=NULL, data.dir=tempdir()) {
  
  if (is.null(which.data)) {
    message("Available HKK address datasets:
  'Seudullinen osoiteluettelo': Osoitetiedot, laajuus: Helsinki, Espoo, Vantaa, Kauniainen.
  'Helsingin osoiteluettelo': Osoitetiedot, laajuus: Helsinki.")
    stop("Please specify 'which.data'")
  }
  
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
  message("Dowloading ", remote.zip, "\ninto ", local.zip, "\n")
  utils::download.file(remote.zip, destfile = local.zip)
  
  # Unzip the downloaded zip file
  utils::unzip(local.zip, exdir = data.dir)
  
  message(paste("For detailed description of", which.data, "data, see description PDF file:", pdf.url))
  
  # Read data
  tab <- read.csv(file.path(data.dir, res.file), fileEncoding = "ISO-8859-1")
  
  message("\nData loaded successfully")
  return(tab)
}
