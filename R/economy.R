# This file is a part of the helsinki package (http://github.com/rOpenGov/helsinki)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2010-2014 Juuso Parkkinen / Louhos <louhos.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


#' Retrieve economic indicators
#'
#' Retrieve economic indicators for the Helsinki region from
#' Helsinki Region Infoshare
#' http://www.hri.fi/fi/data/paakaupunkiseudun-kuntien-taloudellisia-tunnuslukuja/.
#' Helsinki, Espoo, Vantaa, Kauniainen, Finland, years 1998-2010.
#'
#' @param verbose logical. Should R report extra information on progress? 
#' @return results A list with indicator data as a data frame,
#' and additional metadata and notes provided in the original data.
#' 
#' @export
#' 
#' @references See citation("helsinki") 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples \donttest{ res.list <- get_economic_indicators() }

get_economic_indicators <- function (verbose=TRUE) {

  ## Economic indicators; Hel, Esp, Van, Kau, Koko maa; years 1998-2010
  if (verbose)
    message("Reading economic indicators for Helsinki region, years 1998-2010.")
  
  # Read csv from http://www.hri.fi/fi/data/paakaupunkiseudun-kuntien-taloudellisia-tunnuslukuja/
  csv.url <- "http://www.hel2.fi/tietokeskus/data/talous/PKS_kuntien_taloustunnuslukuja_1.csv"
  
  # Check whether url available
  if (!RCurl::url.exists(csv.url)) {
    message(paste("Sorry! Url", csv.url, "not available!\nReturned NULL."))
    return(NULL)
  }
  
  ec.ind <- read.csv(csv.url, sep=";", fileEncoding="ISO-8859-1", skip=2, nrow=160, stringsAsFactors=FALSE)
  # Use 'EUR' for euros
  ec.ind$Tunnusluku <- gsub("\u0080", "EUR", ec.ind$Tunnusluku)
  # Fix numerical values
  ec.ind[3:15] <- lapply(ec.ind[3:15], function(col) as.numeric(gsub(",", ".", col)))
  # Fix year names
  names(ec.ind)[3:15] <- gsub("X", "", names(ec.ind)[3:15])
  
  # Read metadata and notes
  meta.raw <- read.csv(csv.url, sep=";", header=FALSE, fileEncoding="ISO-8859-1", nrow=2, stringsAsFactors=FALSE)
  notes.raw <- read.csv(csv.url, sep=";", header=FALSE, fileEncoding="ISO-8859-1", skip=165, stringsAsFactors=FALSE)
  
  # Return list with data, metadata, and notes
  return(list(data=ec.ind, metadata=meta.raw$V1, notes=notes.raw$V1))
}


