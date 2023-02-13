#' @title Get city administrative regions
#'
#' @description Sf object of city districts in the Helsinki Capital Region.
#'
#' @details See [get_feature_list()] for a list of all available features
#'
#' @param city The desired city. Valid options: *Helsinki*, *Espoo*, *Vantaa*,
#' *Kauniainen*
#' @param level The desired administrative level. Valid options: *suurpiiri*,
#' *tilastoalue*, *pienalue* and *aanestysalue*
#' @param ... For passing parameters to embedded functions, for example
#' *timeout.s* (timeout in seconds) in the case of **gracefully_fail()**
#' internal function
#'
#' @return sf object
#'
#' @source Metropolitan area in districts: <https://hri.fi/data/en_GB/dataset/seutukartta>
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#'
#' @examples
#' \dontrun{
#' map <- get_city_map(city = "helsinki", level = "suuralue")
#' }
#'
#' @importFrom httr parse_url build_url
#' @importFrom sf st_read read_sf st_crs
#'
#' @export
get_city_map <- function(city = NULL, level = NULL, ...) {
  args <- list(...)

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
      stop(cat("Voting districts for", city, "currently unavailable from WFS"))
    }
  }

  url$query <- list(
    service = "wfs",
    version = "1.1.0",
    request = "GetFeature",
    typeName = type_name,
    srsName = "EPSG:3879",
    outputFormat = "GML2"
  )

  request <- httr::build_url(url)

  graceful_result <- gracefully_fail(request, ...)

  if (is.null(graceful_result)) {
    message("Please check your settings or function parameters \n")
    return(invisible(NULL))
  }

  pk_regions <- sf::read_sf(request)

  if (city == "helsinki") {
    object <- pk_regions[which(pk_regions$kunta == "091"), ]
  }

  if (city == "vantaa") {
    object <- pk_regions[which(pk_regions$kunta == "092"), ]
  }

  if (city == "espoo") {
    object <- pk_regions[which(pk_regions$kunta == "049"), ]
  }

  if (city == "kauniainen") {
    object <- pk_regions[which(pk_regions$kunta == "235"), ]
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
