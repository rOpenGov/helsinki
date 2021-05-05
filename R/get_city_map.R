#' @title Get city administrative regions
#' 
#' @description Sf object of city districts
#' 
#' @details See list_features() for a list of all available features
#' 
#' @importFrom httr parse_url build_url
#' @importFrom sf st_read read_sf st_crs
#' 
#' @param city The desired city. Options: Helsinki, Espoo, Vantaa, Kauniainen
#' @param level The desired administrative level. Options are:
#' - "suurpiiri", "tilastoalue", "pienalue" and "aanestysalue"
#'
#' @return sf object
#' 
#' @source Metropolitan area in districts: <https://hri.fi/data/fi/dataset/paakaupunkiseudun-aluejakokartat>
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#' 
#' @examples 
#' \dontrun{
#' map <- get_city_map(city = "helsinki", level = "suuralue")
#' }
#'
#' @export
get_city_map <- function(city = NULL, level = NULL) {
  
  if (is.null(city)) {
    stop("city = NULL. Following inputs are supported: helsinki, 
         vantaa, espoo, kauniainen")
  }
  
  if (is.null(level)) {
    stop("level = NULL. Following inputs are supported: suuralue, 
         tilastoalue, pienalue, aanestysalue")
  }
  
  base_url <- "https://kartta.hel.fi/ws/geoserver/avoindata/wfs"
  url <- httr::parse_url(base_url)
  
  if (!(tolower(city) %in% c("helsinki", "vantaa", "espoo", "kauniainen"))) {
    stop("Following city inputs are supported: 
         helsinki, vantaa, espoo, kauniainen")
  }
  
  if (tolower(level) %in% c("pienalue", "suuralue", "tilastoalue")) {
    type_name <- paste0("avoindata:Seutukartta_aluejako_", level)
  } else if (tolower(level) == "aanestysalue") {
    type_name <- paste0("avoindata:Halke_", level)
  } else {
    stop("Following level inputs are supported: 
         suuralue, tilastoalue, pienalue, aanestysalue")
  }
  
  if (level == "aanestysalue") {
    if (city %in% c("espoo", "kauniainen", "vantaa")) {
      stop(cat("Voting districts for", city,"currently unavailable from WFS"))
    }
  }
    
  url$query <- list(service = "wfs",
                    version = "1.1.0",
                    request = "GetFeature",
                    typeName = type_name,
                    srsName = "EPSG:3879",
                    outputFormat = "GML2")
  
  request <- httr::build_url(url)
  pk_regions <- sf::read_sf(request)
  
  if (city == "helsinki") {
    object <- pk_regions[which(pk_regions$kunta == "091"),]
  }
  
  if (city == "vantaa") {
    object <- pk_regions[which(pk_regions$kunta == "092"),]
  }
  
  if (city == "espoo") {
    object <- pk_regions[which(pk_regions$kunta == "049"),]
  }
  
  if (city == "kauniainen") {
    object <- pk_regions[which(pk_regions$kunta == "235"),]
  }
  
  if (is.na(sf::st_crs(object))) {
    sf::st_crs(object) <- 3879
  }
  
  message("Source: Metropolitan area in districts. The maintainer of the dataset 
  is Helsingin kaupunkiympariston toimiala / Kaupunkimittauspalvelut and the 
  original author is Helsingin, Espoon, Vantaan ja Kauniaisten 
  mittausorganisaatiot. The dataset has been downloaded from Helsinki Region 
  Infoshare service. CC BY 4.0. <https://creativecommons.org/licenses/by/4.0/>")
  
  return(object)
  
}
