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



#' Retrieve District Boundaries in Helsinki
#'
#' Retrieves District Boundaries data (Aluejakorajat) from Helsinki 
#' Real Estate Department (Helsingin 
#' kaupungin kiinteistovirasto, HKK) through the HKK website
#' http://kartta.hel.fi/avoindata/index.html
#'
#' The data (C) 2011 Helsingin kaupunkimittausosasto.
#' 
#' @param map  A string. Specify the name of the Helsinki District Boundary data set to retrieve. Available options: kunta, pienalue, pienalue_piste, suuralue, suuralue_piste, tilastoalue, tilastoalue_piste, aluejako_alueet_ja_pisteet (the last one gives all maps in a single list of shape objects)
#'
#' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
#' @importFrom rgdal readOGR
#' @importFrom rgdal ogrListLayers
#' @export
#' @references
#' See citation("helsinki") 
#' @author Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # sp <- GetDistrictBoundariesHelsinki("tilastoalue"); 
#'           # pdf("~/tmp/tmp.pdf"); PlotShape(sp, "Name"); dev.off()
  
GetDistrictBoundariesHelsinki <- function( map ) {

  # NOTE: in sorvi 0.1.44 data set Aluejakorajat is available through 
  # `GetHRIaluejakokartat`. This functionality could be merged to 
  # `GetHKK` in the future.

  message(paste("Reading Helsinki Aluejakorajat data from ", "http://kartta.hel.fi/avoindata/aineistot/PKS_Kartta_Rajat_KML2011.zip", " (C) HKK 2011"))
  
  data.url <- "http://kartta.hel.fi/avoindata/aineistot/"
  data.dir <- tempdir()  

  # Aluejakorajat:
  # http://kartta.hel.fi/avoindata/aineistot/PKS_Kartta_Rajat_KML2011.zip

  #> dir(data.dir)
  # "Kartta_avoindata_kayttoehdot_v02_3_2011.pdf"

  # Remote zip to download
  remote.zip <- "PKS_Kartta_Rajat_KML2011.zip"
  unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

  # Read the specified map	       
  f <- file.path(data.dir, paste("PKS_", map, ".kml", sep = ""))

  # Shape file or list of shape files; one for each layer
  sp <- readmap(f)

  # Remove temporary directory
  unlink(data.dir, recursive=T)

  return(sp)

}


readmap <- function (f) {

  lyr <- rgdal::ogrListLayers(f)

  maps <- list()
  for (k in 1:length(lyr)) {
    layername <- lyr[[k]]
    message(paste("Reading layer", layername))
    maps[[layername]] <- rgdal::readOGR(f, layer = layername, verbose = TRUE, drop_unsupported_fields=T, dropNULLGeometries=T)
  }

  maps

}

#' Retrieve Election District data 
#' Retrieves Election District data from Helsinki Real Estate Department (Helsingin 
#' kaupungin kiinteistovirasto, HKK) through the HKK website
#' http://kartta.hel.fi/avoindata/index.html
#'
#' The data (C) 2011 Helsingin kaupunkimittausosasto.
#' 
#' @param city Name the municipality for which to retrieve the election districts
#'
#' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
#' @export
#' @references
#' See citation("helsinki") 
#' @author Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # sp <- GetElectionDistrictsHKK()

GetElectionDistrictsHKK <- function( ) {
  
  data.url <- "http://kartta.hel.fi/avoindata/aineistot/"
  data.dir <- tempdir()  

    # Remote zip to download
    remote.zip <- "pk_seudun_aanestysalueet.zip"
    unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

    # dir(data.dir)

    # Paakaupunkiseudun aanestysalueiden tunnukset ja nimet Tilastokeskuksen 
    # StatFin-vaalitietopalvelussa 2012. Not used in this function for now.
    # Since these seem to be listed in the final shapefile anyway.
    #"Aanestysaluekoodit.xls" 

    #"Avoin lisenssi aanestysalueet.pdf" 
    #"PKS_aanestysalueet_kkj2.DAT" -> Associated with the TAB file?      
    #"PKS_aanestysalueet_kkj2.ID"  -> Associated with the TAB file?      
    #"PKS_aanestysalueet_kkj2.MAP" -> Associated with the TAB file?      
    #"PKS_aanestysalueet_kkj2.TAB" -> Used in this function     
    #"PKS_aanestysalueet_kkj2.txt" -> Skipped for now, presumably the 
    #                                 same information as in the mapinfo files

    mapinfo.file <- file.path(data.dir, "PKS_aanestysalueet_kkj2.TAB")
    
    sp.cities <- rgdal::readOGR(mapinfo.file, 
                                 layer = rgdal::ogrListLayers(mapinfo.file))
    
    # Fix encoding
    sp.cities@data$TKNIMI <- factor(iconv(sp.cities@data$TKNIMI, 
                                          from="ISO-8859-1", to="UTF-8"))
    sp.cities@data$Nimi <- factor(iconv(sp.cities@data$Nimi, 
                                        from="ISO-8859-1", to="UTF-8"))
    # Remove temporary directory
    unlink(data.dir, recursive=T)
    
    return(sp.cities)
    
}


 
   
