#' @title Produce an SF object: Vaestotietoruudukko
#'
#' @description Produces an sf object for Väestötietoruudukko (population grid).
#'
#' @details Additional data not available here can be manually downloaded from
#' HRI website: <https://hri.fi/data/fi/dataset/vaestotietoruudukko>
#'
#' Years 1997-2003 and 2008-2021 are tested to work at the time of development.
#' Datasets from years 2015-2021 are downloaded from HSY WFS API and datasets
#' for other years are downloaded as zip files from HRI website. The format of
#' the output might be a bit different between datasets downloaded from the WFS
#' API and datasets downloaded from HRI website.
#'
#' Additional years may be added in the future and older datasets may be removed
#' from the API. See package NEWS for more information.
#'
#' The current datasets can be listed with [get_feature_list()]
#' or [select_feature()].
#'
#' @param year a single year as numeric between 1997-2003 and 2008:2021.
#' If NULL (default), the function will return the latest available dataset.
#'
#' @return sf object
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#'
#' @importFrom sf read_sf
#' @importFrom utils unzip download.file
#'
#' @examples
#' \dontrun{
#' pop_grid <- get_vaestotietoruudukko(year = 2021)
#' }
#'
#' @export
get_vaestotietoruudukko <- function(year = NULL) {
  namespace_title <- "asuminen_ja_maankaytto:Vaestotietoruudukko"
  base_url <- "https://kartta.hsy.fi/geoserver/wfs"
  valid_years <- c(1997:2003, 2008:2021)
  missing_years <- 2004:2007
  wfs_valid_years <- 2015:2021

  if (is.null(year)) {
    message(paste(
      "year = NULL! Retrieving feature from latest available year:",
      max(valid_years)
    ))
    year <- max(valid_years)
  }

  if (!(year %in% valid_years)) {
    message(paste0(
      "It is strongly suggested to use a valid year from range: ",
      min(valid_years), "-", max(valid_years),
      " (excluding years ", min(missing_years), "-",
      max(missing_years), "). ",
      "Using other years will most probably result in an error."
    ))
  }

  if (year %in% wfs_valid_years) {
    selection <- paste(namespace_title, year, sep = "_")

    feature <- get_feature(base.url = base_url, typename = selection)
    return(feature)
  } else {
    metadata <- get_hri_dataset_metadata("vaestotietoruudukko")

    if (is.null(metadata)) {
      message("Please check your settings or function parameters \n")
      return(invisible(NULL))
    }

    p <- c(year, "shp")
    matching_rows <- sapply(p, grep, metadata$resources$name)
    desired_file_index <- intersect(matching_rows[[1]], matching_rows[[2]])
    url <- metadata$resources$url[desired_file_index]
    td <- tempdir()
    tf <- tempfile(tmpdir = td, fileext = ".zip")
    utils::download.file(url, tf)
    target_directory <- paste(td, "shapefiles", sep = "/")
    utils::unzip(tf, exdir = target_directory)
    feature <- sf::read_sf(target_directory)
    return(feature)
  }
}

#' @title Produce an SF object: Rakennustietoruudukko
#'
#' @description Produces an sf object for Rakennustietoruudukko (building
#' information grid).
#'
#' @details Additional data not available here can be manually downloaded from
#' HRI website: <https://hri.fi/data/fi/dataset/rakennustietoruudukko>
#'
#' Years 2015-2021 are tested to work at the time of development.
#' Additional years may be added in the future and older datasets may be removed
#' from the API. Datasets from years 2015-2021 are downloaded from HSY WFS API and datasets
#' for other years are downloaded as zip files from HRI website. The format of
#' the output might be a bit different between datasets downloaded from the WFS
#' API and datasets downloaded from HRI website.
#'
#' Additional years may be added in the future and older datasets may be removed
#' from the API. See package NEWS for more information.
#'
#' The current datasets can be listed with [get_feature_list()]
#' or [select_feature()].
#'
#' @param year year as numeric between 1997-1998 and 2009-2021.
#' If NULL (default), the function will return the latest available dataset.
#'
#' @return sf object
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#'
#' @examples
#' \dontrun{
#' building_grid <- get_rakennustietoruudukko(year = 2021)
#' }
#'
#' @importFrom sf read_sf
#' @importFrom utils unzip download.file
#'
#' @export
get_rakennustietoruudukko <- function(year = NULL) {
  namespace_title <- "asuminen_ja_maankaytto:Rakennustietoruudukko"
  base_url <- "https://kartta.hsy.fi/geoserver/wfs"
  valid_years <- c(1997:1998, 2009:2021)
  missing_years <- 1999:2008
  wfs_valid_years <- 2015:2021

  if (is.null(year)) {
    message(paste0("year = NULL! Retrieving feature from year ", max(valid_years)))
    year <- max(valid_years)
  }

  if (!(year %in% valid_years)) {
    message(paste0(
      "It is strongly suggested to use a valid year from range: ",
      min(valid_years), "-", max(valid_years),
      " (excluding years ", min(missing_years), "-",
      max(missing_years), "). ",
      "Using other years will most probably result in an error."
    ))
  }

  if (year %in% wfs_valid_years) {
    selection <- paste(namespace_title, year, sep = "_")

    feature <- get_feature(base.url = base_url, typename = selection)
    return(feature)
  } else {
    metadata <- get_hri_dataset_metadata("vaestotietoruudukko")

    if (is.null(metadata)) {
      message("Please check your settings or function parameters \n")
      return(invisible(NULL))
    }

    p <- c(year, "shp")
    matching_rows <- sapply(p, grep, metadata$resources$name)
    desired_file_index <- intersect(matching_rows[[1]], matching_rows[[2]])
    url <- metadata$resources$url[desired_file_index]

    td <- tempdir()
    tf <- tempfile(tmpdir = td, fileext = ".zip")
    utils::download.file(url, tf)
    target_directory <- paste(td, "shapefiles", sep = "/")
    utils::unzip(tf, exdir = target_directory)
    feature <- sf::read_sf(target_directory)
    return(feature)
  }
}
