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


#' Helsinki region district maps (aluejakokartat)
#' 
#' Helsinki region district maps (aluejakokartat, aanestysalueet) from
#' Helsinki Real Estate Department (Helsingin kaupungin kiinteistovirasto, HKK)
#' through the HKK website http://ptp.hel.fi/avoindata/index.html.
#' The data are retrieved and preprocessed using the fingis package,
#' see details in https://github.com/louhos/takomo/helsinki/
#'
#' @name aluejakokartat
#' @docType data
#' @references See citation("helsinki") 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @keywords data
#' @examples data(aluejakokartat)
NULL

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
#' @examples tab <- get_HKK_address_data("Helsingin osoiteluettelo")

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
  if (!file.exists(local.zip)) {
    message("Dowloading ", remote.zip, "\ninto ", local.zip, "\n")
    utils::download.file(remote.zip, destfile = local.zip)
  } else {
    message("File ", local.zip, " already found, will not download again!")
  }  
  # Unzip the downloaded zip file
  utils::unzip(local.zip, exdir = data.dir)
  
  message(paste("For detailed description of", which.data, "data, see description PDF file:", pdf.url))
  
  # Read data
  tab <- read.csv(file.path(data.dir, res.file), fileEncoding = "ISO-8859-1")
  
  message("\nData loaded successfully")
  return(tab)
}
