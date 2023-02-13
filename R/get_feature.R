#' @title Produce an SF object
#'
#' @description Produces an sf object for easy visualization
#'
#' @seealso Use \code{\link{get_feature_list}} to list all available features
#' for a given WFS, \code{\link{select_feature}} for listing and selecting a
#' feature
#'
#' @param base.url WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"
#' @param typename accepts feature names, e.g. "asuminen_ja_maankaytto:1000m_verkostobufferi"
#' No short form titles here, e.g. "1000m_verkostobufferi"!
#' @param CRS Default CRS is 3879 (or EPSG:3879), see ?sf::st_crs for other input options
#'
#' @return sf object
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#'
#' @importFrom sf st_crs
#'
#' @export
get_feature <- function(base.url = "https://kartta.hsy.fi/geoserver/wfs",
                        typename = "asuminen_ja_maankaytto:Vaestotietoruudukko_2015",
                        CRS = 3879) {
  user_input <- list(
    service = "WFS",
    version = "1.1.0",
    request = "getFeature",
    typeName = typename
  )
  feature <- wfs_api(base.url = base.url, queries = user_input)
  if (is.null(feature)) {
    return(invisible(NULL))
  }
  sf_obj <- to_sf(feature)
  if (is.na(sf::st_crs(sf_obj))) {
    if (!is.null(CRS)) {
      sf::st_crs(sf_obj) <- CRS
    }
  }
  sf_obj
}
