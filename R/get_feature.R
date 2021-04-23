#' @title Produce an SF object
#' 
#' @description Produces an sf object for easy visualization
#' 
#' @details See list_features() for a list of all available features
#' 
#' @param typeName accepts feature names, e.g. "asuminen_ja_maankaytto:1000m_verkostobufferi"
#' No short form titles here, e.g. "1000m_verkostobufferi"!
#'
#' @return sf object
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#'
#' @export
get_feature <- function(typeName = "asuminen_ja_maankaytto:Vaestotietoruudukko_2015") {
  user_input <- list(service = "WFS", 
                     version = "2.0.0", 
                     request = "getFeature", 
                     typeName = typeName)
  feature <- wfs_api(queries = user_input)
  sf_obj <- to_sf(feature)
  sf_obj
}
