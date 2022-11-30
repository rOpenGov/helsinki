#' @title Print all available Features
#' 
#' @description Basically a neat wrapper for "request=GetCapabilities".
#' 
#' @details Lists all `<FeatureType>` nodes.
#' 
#' @seealso Use [get_feature()] to download feature, 
#' [select_feature()] for menu-driven listing and downloading
#' 
#' @param base.url WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"
#' @param queries desired query for acquiring the list of features, default 
#'    is "request=GetCapabilities"
#'
#' @return data frame
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#' 
#' @examples 
#' \dontrun{
#' dat <- get_feature_list(base.url = "https://kartta.hsy.fi/geoserver/wfs")
#' }
#' 
#' @import dplyr
#' @importFrom purrr flatten_dfc
#' @importFrom xml2 as_list xml_find_all xml_ns_strip
#'
#' @export
get_feature_list <- function(base.url = NULL, 
                             queries = c("request" = "GetCapabilities")) {
  
  if (is.null(base.url)) {
    message("base.url = NULL. Using https://kartta.hsy.fi/geoserver/wfs")
    base.url <- "https://kartta.hsy.fi/geoserver/wfs"
  }
  
  resp <- wfs_api(base.url = base.url, queries = queries)
  content <- resp$content
  
  # For some reason this seems to be a necessary step for xml_find_all to work
  content_ns_strip <- xml_ns_strip(content)
  
  # Find all "<FeatureType>" nodes
  all_features <- xml_find_all(x = content_ns_strip, xpath = "//FeatureType ")
  
  # Initialize an empty data.frame
  df <- data.frame(matrix(NA, nrow = length(all_features), ncol = 2))
  names(df) <- c("Name", "Title")
  
  for (i in seq_len(length(all_features))) {
    all_features_list <- as_list(all_features[[i]])
    df[i,] <- flatten_dfc(all_features_list[c("Name", "Title")])
  }
  
  df$Namespace <- gsub(":.*", "", df$Name)
  
  df
}

#' @title Interactively browse and select features
#' 
#' @description Use an interactive menu to select and download a feature 
#' for use in other functions
#'
#' @seealso \code{\link{get_feature}}, \code{\link{get_feature_list}}
#'
#' @return feature Title (character) or feature object (sf), if \code{get} parameter is TRUE
#' 
#' @param base.url WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"
#' @param get Should the selected feature be downloaded? Default is \code{FALSE}
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
#' @importFrom utils select.list
#'
#' @export
select_feature <- function(base.url = NULL, get = FALSE) {
  df <- get_feature_list(base.url = base.url)
  unique_namespace <- unique(df$Namespace)
  selected_namespace <- select.list(choices = unique_namespace,
                                    title = "From which namespace?",
                                    graphics = FALSE)
  
  df2 <- df[which(df$Namespace == selected_namespace),]
  
  selected_title <- select.list(choices = df2$Title,
                                title = "Which dataset?",
                                graphics = FALSE)
  
  # Name = Namespace:Title
  selected_row <- df[which(df$Title == selected_title),]
  selected_name <- selected_row$Name
  
  if (get == TRUE) {
    object <- get_feature(base.url = base.url, typename = selected_name)
    return(object)
  } else {
    return(selected_name)
  }
}

#' @title List HRI datasets
#' 
#' @details This function lists all available HRI datasets.
#' 
#' @importFrom jsonlite fromJSON
#' @keywords internal
get_hri_dataset_list <- function() {
  url <- "https://hri.fi/data/api/3/action/package_list"
  package_list <- jsonlite::fromJSON(url)
  result <- package_list$result
  result
}

#' @title Get HRI dataset metadata
#' 
#' @details This function fetches metadata for HRI datasets.
#' 
#' @importFrom jsonlite fromJSON
#' @keywords internal
get_hri_dataset_metadata <- function(id) {
  datasets <- get_hri_dataset_list()
  
  if (is.null(id)) {
    stop("function id is NULL. Please input a valid id")
  }
  
  if (!(id %in% datasets)) {
    stop("function id not available in HRI. Please input a valid id")
  }
  
  url <- "https://hri.fi/data/api/action/package_show?id="
  url <- paste0(url, id)

  dataset_metadata <- jsonlite::fromJSON(url)
  result <- dataset_metadata$result
  result
}
