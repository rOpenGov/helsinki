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
#' @author Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # sp <- GetHKK("Aanestysaluejako")

GetHKK <- function( which.data ) {
  
  data.url <- "http://kartta.hel.fi/avoindata/aineistot/"
  data.dir <- tempdir()  

  if (which.data == "Aanestysaluejako") {

    # Remote zip to download
    remote.zip <- "pk_seudun_aanestysalueet.zip"
    unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

    # dir(data.dir)
    # Paakaupunkiseudun aanestysalueiden tunnukset ja nimet Tilastokeskuksen 
    # StatFin-vaalitietopalvelussa 2012. Not used in this function for now.
    # Since these seem to be in the final shapefile anyway.
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
    
  } else if (which.data == "Aluejakorajat") {

    # Aluejakorajat:
    # http://kartta.hel.fi/avoindata/aineistot/PKS_Kartta_Rajat_KML2011.zip

    #> dir(data.dir)
    # "Kartta_avoindata_kayttoehdot_v02_3_2011.pdf"
    # "PKS_aluejako_alueet_ja_pisteet.kml"         
    # "PKS_kunta.kml"                              
    # "PKS_pienalue.kml"                           
    # "PKS_pienalue_piste.kml"                     
    # "PKS_suuralue.kml"                           
    # "PKS_suuralue_piste.kml"                     
    # "PKS_tilastoalue.kml"                        
    # "PKS_tilastoalue_piste.kml"         

    # Remote zip to download
    remote.zip <- "PKS_Kartta_Rajat_KML2011.zip"
    unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

    #mapinfo.file <- file.path(data.dir, "PKS_aanestysalueet_kkj2.TAB")
    #sp.cities <- rgdal::readOGR(mapinfo.file, 
    #                             layer = rgdal::ogrListLayers(mapinfo.file))
    # Fix encoding
    #sp.cities@data$TKNIMI <- factor(iconv(sp.cities@data$TKNIMI, 
    #                                      from="ISO-8859-1", to="UTF-8"))

    # Remove temporary directory
    #unlink(data.dir, recursive=T)
    
    #return(sp.cities)

    stop(paste(which.data, "not implemented. Try GetHRIaluejakokartat instead."))

    # NOTE: in sorvi 0.1.44 data set Aluejakorajat is available through 
    # `GetHRIaluejakokartat`. This functionality could be merged to 
    # `GetHKK` in the future.

  } else if (which.data == "Seutukartta") {

    # Seutukartta: 
    # http://kartta.hel.fi/avoindata/aineistot/sk11_avoin.zip
    
    # Remote zip to download
    remote.zip <- "sk11_avoin.zip"
    unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

    message(paste(which.data, "contains a number of MAPINFO files. To be implemented."))

    stop(paste(which.data, "not implemented"))

  } else if (which.data == "Seudullinen osoiteluettelo") {

    # Seudullinen osoiteluettelo
    # http://kartta.hel.fi/avoindata/aineistot/Seudullinen_osoiteluettelo.zip
    remote.zip <- "Seudullinen_osoiteluettelo.zip"
    unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

    # "Seudullinen_osoiteluettelo.csv"             
    # "Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf"

    stop(paste(which.data, "not implemented"))

  } else if (which.data == "Helsingin osoiteluettelo") {

    # Helsingin osoiteluettelo:
    # http://kartta.hel.fi/avoindata/aineistot/Helsingin_osoiteluettelo.zip

    remote.zip <- "Helsingin_osoiteluettelo.zip"
    unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

    # "Helsingin_osoiteluettelo.csv"    

    stop(paste(which.data, "not implemented"))

  } else if (which.data == "Helsingin piirijako") {

    # Helsingin piirijako:
    # http://kartta.hel.fi/avoindata/aineistot/Helsingin_piirijako_2013.zip

    remote.zip <- "Helsingin_piirijako_2013.zip"
    unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

    message(paste(which.data, "contains a number of MAPINFO files. To be implemented."))
    stop(paste(which.data, "not implemented"))

  } else if (which.data == "Helsingin kaupungin rakennusrekisterin ote") {

    # Helsingin kaupungin rakennusrekisterin ote:
    # http://kartta.hel.fi/avoindata/aineistot/rakennukset_Helsinki_06_2012.zip

    remote.zip <- "rakennukset_Helsinki_06_2012.zip"
    unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

    # "Metatieto_rakennukset.xls"
    # "rakennukset_helsinki_20m2_hkikoord" 
    # "rakennukset_Helsinki_etrsgk25"     
    # "rakennukset_Helsinki_hkikoord"      
    # "rakennukset_Helsinki_wgs84"        

    message(paste(which.data, "contains a number of MAPINFO files. To be implemented."))
    stop(paste(which.data, "not implemented"))

  } else {

    stop(paste(which.data, "is not a valid data set descriptor"))

  }

}


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
 
   
