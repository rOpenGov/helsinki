#' Retrieve HKK data 
#'
#' This script retrieves data from Helsinki Real Estate Department (Helsingin 
#' kaupunki kiinteistovirasto HKK) through the HKK website
#' http://kartta.hel.fi/avoindata/index.html
#' For details, see the HKK website
#'
#' The data copyright is on Helsingin kaupunkimittausosasto (C)  2011.
#' 
#' @param which.data  A string. Specify the name of the HKK data set to retrieve. Currently available options: Aluejakokartat;Aanestysaluejako;Seutukartta Rakennustietoruudukko; SeutuRAMAVA; key.KATAKER.
#' @param data.dir A string. Specify the path where to save the downloaded data. A new subdfolder "aanestysalueet" will be created.
#'
#' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
#' @export
#' @references
#' See citation("sorvi") 
#' @author Joona Lehtomaki \email{louhos@@googlegroups.com}
#' @examples # sp <- GetHKK("Aanestysaluejako", data.dir="C:/data")

GetHKK <- function(which.data, data.dir) {
  
  .InstallMarginal("rgdal")
  
  # TODO: shold all the urls/paths be defined independently from the functions?
  data.url <- "http://kartta.hel.fi/avoindata/aineistot/"
  
  # Create data.fir if does not exist
  if (!file.exists(data.dir))
    dir.create(data.dir)
  
  if (which.data == "Aanestysaluejako") {
    
    # Remote zip that will be downloaded
    remote.zip <- "pk_seudun_aanestysalueet.zip"
    # Location and name of the zip file that will be saved on the local computer
    local.zip <- file.path(data.dir, remote.zip)
    # Create the web address from where to fetch the zip
    data.url <- paste(data.url, remote.zip, sep = "")
    message(paste("Dowloading HKK data from ", data.url, "in file", local.zip))
    download.file(data.url, destfile = local.zip)
    # Unzip the downloaded zip file
    data.dir <- file.path(data.dir, "aanestysalueet")
    unzip(local.zip, exdir=data.dir)
    
    mapinfo.file <- file.path(data.dir, "PKS_aanestysalueet_kkj2.TAB")
    
    sp.cities <- rgdal::readOGR(mapinfo.file, 
                                 layer = rgdal::ogrListLayers(mapinfo.file))
    
    # Fix encoding
    sp.cities@data$TKNIMI <- factor(iconv(sp.cities@data$TKNIMI, 
                                          from="ISO-8859-1", to="UTF-8"))
    sp.cities@data$Nimi <- factor(iconv(sp.cities@data$Nimi, 
                                        from="ISO-8859-1", to="UTF-8"))
    # Remove TEMP file
    unlink("TEMP", recursive=T)
    
    return(sp.cities)
    
  } else if (which.data == "Aluejakokartat") {
    stop("Not implemented yet; Try GetHRIaluejakokartat instead")
  } else if (which.data == "Seutukartta") {
    stop("Not implemented yet")
  } else {
    stop(paste(which.data, "is not a valid data set descriptor"))
  }
}

