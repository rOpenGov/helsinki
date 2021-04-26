## get_hsy()
#' @title Retrieve data from Helsinki Region Environmental Services.
#' @description Retrieves data from Helsinki Region Environmental Services Authority.
#' @param which.data A string. Specify the name of the retrieved HSY data set. Options: Vaestotietoruudukko; Rakennustietoruudukko; SeutuRAMAVA_kosa; SeutuRAMAVA_tila. These are documented in HSY data description document (see above).
#' @param which.year An integer. Specify the year for the data to be retrieved.
#' @param data.dir A string. Specify a temporary folder for storing downloaded data.
#' @param verbose logical. Should R report extra information on progress? 
#' @return Shape object (from SpatialPolygonsDataFrame class)
#'
#' @name get_hsy-deprecated
#' @usage get_hsy(which.data, which.year, data.dir, verbose)
#' @seealso \code{\link{helsinki-deprecated}}
#' @keywords internal
NULL

#' @rdname helsinki-deprecated
#' @section \code{get_hsy}:
#' For \code{get_hsy(which.data="Vaestotietoruudukko")}, use \code{\link{get_vaestotietoruudukko}}.
#' For \code{get_hsy(which.data="Rakennustietoruudukko")}, use \code{\link{get_rakennustietoruudukko}}.
#'
#' @export
get_hsy <- function(which.data=NULL, which.year=2013, data.dir=tempdir(), verbose=TRUE) {
  
  # Specify download url
  if (which.data=="Vaestotietoruudukko") {
    .Deprecated(new = "get_vaestotietoruudukko", package = "helsinki")
    message("get_hsy() has been deprecated, use get_vaestotietoruudukko() instead")
    return(NULL)
    
  } else if (which.data=="Rakennustietoruudukko") {
    .Deprecated(new = "get_rakennustietoruudukko", package = "helsinki")
    message("get_hsy() has been deprecated, use get_vaestotietoruudukko() instead")
    return(NULL) 
    
  } else if (is.null(which.data)) {
    .Deprecated("get_feature")
    message("get_hsy() has been deprecated, use get_feature_list() to browse for available HSY features and get_feature() to download them")
    return(NULL)
    
  } else {
    .Deprecated("get_feature")
    message("get_hsy() has been deprecated, use get_feature_list() to browse for available HSY features and get_feature() to download them")
    return(NULL)
  }
    
}

#' @title Produce an SF object: Vaestotietoruudukko
#' 
#' @description Produces an sf object for Väestötietoruudukko (population grid)
#' 
#' @details Additional data not available here can be manually downloaded from HRI website: https://hri.fi/data/fi/dataset/vaestotietoruudukko
#' 
#' Years 2015-2019 are tested to work at the time of development. 
#' Additional years may be added in the future and older datasets may be removed
#' from the API. 
#' 
#' The current datasets can be listed with get_feature_list()
#' or select_feature(). 
#' 
#' @param year year as numeric from range 2015:2019
#'
#' @return sf object
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#'
#' @examples
#' \dontrun{
#' pop_grid <- get_vaestotietoruudukko(year = 2015)
#' }
#'
#' @export
get_vaestotietoruudukko <- function(year = NULL) {
  namespace_title <- "asuminen_ja_maankaytto:Vaestotietoruudukko"
  base_url <- "https://kartta.hsy.fi/geoserver/wfs"
  valid_years <- 2015:2019
  
  if (is.null(year)) {
    message(paste0("year = NULL! Retrieving feature from year ", max(valid_years)))
    year <- max(valid_years)
  }
  
  if (!(year %in% valid_years)) {
    message(paste0("It is strongly suggested to use a valid year from range: 2015-2019. 
                   Using other years may result in an error."))
  }
  
  selection <- paste(namespace_title, year, sep = "_")
  
  feature <- get_feature(base.url = base_url, typename = selection)
  feature
}

#' @title Produce an SF object: Rakennustietoruudukko
#' 
#' @description Produces an sf object for Rakennustietoruudukko (building information grid)
#' 
#' @details Additional data not available here can be manually downloaded from HRI website: https://hri.fi/data/fi/dataset/rakennustietoruudukko
#' 
#' Years 2015-2019 are tested to work at the time of development. 
#' Additional years may be added in the future and older datasets may be removed
#' from the API. 
#' 
#' The current datasets can be listed with get_feature_list()
#' or select_feature(). 
#' 
#' @param year year as numeric from range 2015:2019
#'
#' @return sf object
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#' 
#' @examples
#' \dontrun{
#' building_grid <- get_rakennustietoruudukko(year = 2016)
#' }
#'
#' @export
get_rakennustietoruudukko <- function(year = NULL) {
  namespace_title <- "asuminen_ja_maankaytto:Rakennustietoruudukko"
  base_url <- "https://kartta.hsy.fi/geoserver/wfs"
  valid_years <- 2015:2019
  
  if (is.null(year)) {
    message(paste0("year = NULL! Retrieving feature from year ", max(valid_years)))
    year <- max(valid_years)
  }
  
  if (!(year %in% valid_years)) {
    message(paste0("It is strongly suggested to use a valid year from range: 2015-2019. 
                   Using other years may result in an error."))
  }
  
  if (year == 2016) {
    selection <- paste(namespace_title, year, "2", sep = "_")
  } else {
    selection <- paste(namespace_title, year, sep = "_")
  }
  
  feature <- get_feature(base.url = base_url, typename = selection)
  feature
}