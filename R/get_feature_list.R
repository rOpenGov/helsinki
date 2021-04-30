#' @title Print all available Features
#' 
#' @description Basically a neat wrapper for "request=GetCapabilities".
#' 
#' @details Lists all <FeatureType> nodes.
#' 
#' @param base.url a WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"
#'
#' @return data frame
#' 
#' @importFrom purrr flatten_dfc
#' @importFrom xml2 as_list xml_find_all xml_ns_strip
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#' 
#' @examples 
#' dat <- get_feature_list(base.url = "https://kartta.hsy.fi/geoserver/wfs")
#'
#' @export
get_feature_list <- function(base.url = NULL) {
  
  if (is.null(base.url)) {
    message("base.url = NULL. Using https://kartta.hsy.fi/geoserver/wfs")
    base.url <- "https://kartta.hsy.fi/geoserver/wfs"
  }
  
  resp <- wfs_api(base.url = base.url, queries = "request=GetCapabilities")
  content <- resp$content
  
  # For some reason this seems to be a necessary step
  # for xml_find_all to function
  content_ns_strip <- xml2::xml_ns_strip(content)
  
  # All "<FeatureType>" nodes
  kaikki <- xml2::xml_find_all(x = content_ns_strip, xpath = "//FeatureType ")
  
  df <- data.frame(matrix(NA, nrow = length(kaikki), ncol = 2))
  names(df) <- c("Name", "Title")
  
  for (i in 1:length(kaikki)) {
    kaikki_list <- xml2::as_list(kaikki[[i]])
    df[i,] <- purrr::flatten_dfc(kaikki_list[c("Name", "Title")])
  }
  
  df$Namespace <- gsub(":.*", "", df$Name)
  
  # Without using flatten_dfc
  #for (i in 1:length(kaikki)) {
  #  kaikki_list <- xml2::as_list(kaikki[[i]])
  #  flatten_list <- purrr::flatten(kaikki_list)
  #  df[i,] <- as.data.frame(flatten_list[c("Name", "Title")])
  # }
  
  df
}

#' @title Interactively browse and select features
#' 
#' @description Select wanted feature for use in other functions
#'
#' @return feature Title (character) or feature object
#' 
#' @param base.url WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"
#' @param get Should the selected feature be also downloaded? Default is FALSE
#' 
#' @importFrom utils menu
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#' 
#' @examples 
#' \dontrun{
#' selection <- select_feature(base.url = "https://kartta.hsy.fi/geoserver/wfs")
#' feature <- get_feature(base.url = "https://kartta.hsy.fi/geoserver/wfs", type_name = selected)
#' ggplot(feature) +
#'   geom_sf()
#' }
#'
#' @export
select_feature <- function(base.url = NULL, get = FALSE) {
  df <- get_feature_list(base.url = base.url)
  unique_namespace <- unique(df$Namespace)
  selection <- menu(choices = unique_namespace,
                    title = "From which namespace?")
  selection2 <- menu(choices = df$Title[which(df$Namespace == unique_namespace[selection])],
                     title = "Which dataset?")
  selected_dataset_name <- df$Name[which(df$Title == df$Title[selection2])]
  if (get == TRUE) {
    object <- get_feature(base.url = base.url, typename = selected_dataset_name)
    return(object)
  } else {
    return(selected_dataset_name)
  }
}
