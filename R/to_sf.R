#' @title Transform to sf-object
#'
#' @description Transform a wfs_api object into a sf object.
#'
#' @details FMI API response object's XML (GML) content is temporarily wrtitten on disk
#' and then immediately read back in into a sf object.
#'
#' @param api_obj wfs api object
#'
#' @return sf object
#'
#' @importFrom methods is
#' @importFrom sf st_read
#' @importFrom xml2 write_xml
#'
#' @note For internal use, not exported.
#'
#' @author Joona Lehtomäki <joona.lehtomaki@@iki.fi>
#'
#' @keywords utilities
to_sf <- function(api_obj) {
  if (!methods::is(api_obj, "wfs_api")) {
    stop("Object provided must be of class wfs_api, not ", class(api_obj))
  }
  # Get response content
  content <- api_obj$content
  # Write the content to disk
  destfile <- paste(tempfile(), ".gml", sep = "")
  xml2::write_xml(content, destfile)

  # Read the temporary GML file back in
  features <- sf::st_read(destfile, quiet = TRUE)

  return(features)
}
