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


#' Retrieve population projection data
#'
#' Retrieve population projection data (vaestoennuste) by age and gender
#' from Helsinki Region Infoshare
#' http://www.hri.fi/fi/data/helsingin-ja-helsingin-seudun-vaestoennuste-sukupuolen-ja-ian-mukaan-2012-2050/
#' Helsinki, Helsinki region, 2012-2050
#'
#' @param verbose logical. Should R report extra information on progress? 
#' @return results A list with indicator data as a data frame,
#' and additional metadata provided in the original data.
#' 
#' @export
#' 
#' @references See citation("helsinki") 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples \donttest{ res.list <- get_population_projection()}

get_population_projection <- function (verbose=TRUE) {
  
  if (verbose)
    message("Reading population projections for Helsinki and Helsinki region, years 2012-2050.")
  
  # Read csv from http://www.hri.fi/fi/data/helsingin-ja-helsingin-seudun-vaestoennuste-sukupuolen-ja-ian-mukaan-2012-2050/
  csv.url <- "http://www.hel2.fi/tietokeskus/data/helsinki/Vaestoennusteet/Helsingin_seudun_vaestoennuste_ika_sp_2012_2050.csv"
  pop.proj <- read.csv(csv.url, sep=";", fileEncoding="ISO-8859-1", skip=3, stringsAsFactors=FALSE)
  
  # Read metadata
  meta.raw <- read.csv(csv.url, sep=";", header=FALSE, fileEncoding="ISO-8859-1", nrow=3, stringsAsFactors=FALSE)
  return(list(data=pop.proj, metadata=meta.raw$V1))
}


