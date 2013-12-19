#' Retrieve HKK data 
#'
#' Retrieves data from Helsinki Real Estate Department (Helsingin 
#' kaupungin kiinteistovirasto, HKK) through the HKK website
#' http://kartta.hel.fi/avoindata/index.html
#'
#' The data (C) 2011 Helsingin kaupunkimittausosasto.
#' 
#' @param which.data  A string. Specify the name of the HKK data set to retrieve. Options: Aluejakokartat;Aanestysaluejako;Seutukartta Rakennustietoruudukko; SeutuRAMAVA; key.KATAKER.
#' @param data.dir A string. Specify the path where to save the downloaded data. A new subdfolder "aanestysalueet" will be created.
#'
#' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
#' @export
#' @references
#' See citation("helsinki") 
#' @author Joona Lehtomaki \email{louhos@@googlegroups.com}
#' @examples # sp <- GetHKK("Aanestysaluejako", data.dir=".")

GetHKK <- function(which.data, data.dir) {
  
  # FIXME: Harmonize functionality with `GetHSY`
  #@param `which.data` a string with one of the values `"Aluejakorajat"`, `"Aanesysaluejako"` or `"Seutukartta"`  
  #@return **Undecided**: either (1) a Shape object or (2) a list of Shape objects (from `SpatialPolygonsDataFrame` class)
  #NOTE: in sorvi 0.1.44 data set Aluejakorajat is available through `GetHRIaluejakokartat`. This functionality could be merged to `GetHKK` in the future.
## Work stages

  #1. Download the requested data set from HKK-webpages
  #2. Unzip the data set into a predefined location [SORVI_PKG_LOCATION]/extdata (should the location be included in the function call?)
  # At this point the pre-processing of the datasets diverge  

  # `Aanestysaluejako`
  # Data set includes the elections districts for the cities of the capital region (Helsinki, Espoo, Kauniainen and Vantaa) in MapInfo-format (OGR will handle these just fine). CRS is Finland KKJ2 (EPSG: 2392). All feature datasets have different schemas with varying amount of information. Additionally there is an Excel file (Aanestyaluekoodit.xls) with information for all cities, such as voting district names and codes.

  #1. Extract the information for each city from Excel-sheets into data frames (`read.xls`)
  # 2. Pre-process the fields in the voting information (break down fields, handle encoding etc.)
  # 3. Read in the spatial data for each city (`readOGR`)
  # 4. Merge data from the voting information tables and the spatial data
  # 5. Either  
  #* return a list of `SpatialPolygonDataframes`  
  #* Merge all cities into 1 sp-object. This could be done e.g. using `spRbind`. Note that biding the sp-objects would call for defining unique FIDs for all the polygons using `spChFIDs` on the voting district code



  #.InstallMarginal("rgdal")
  
  # TODO: shold all the urls/paths be defined independently from the functions?
  data.url <- "http://kartta.hel.fi/avoindata/aineistot/"
  
  # Create data.dir if does not exist
  # FIXME use temporary data dir
  if (!file.exists(data.dir))
    dir.create(data.dir)
  
  if (which.data == "Aanestysaluejako") {
    
    # Remote zip to download
    remote.zip <- "pk_seudun_aanestysalueet.zip"

    # Local zip location 
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
    stop(paste(which.data, "not implemented. Try GetHRIaluejakokartat instead."))
  } else if (which.data == "Seutukartta") {
    stop(paste(which.data, "not implemented"))
  } else {
    stop(paste(which.data, "is not a valid data set descriptor"))
  }
}

