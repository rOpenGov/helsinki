#' @title Print all available Features
#' 
#' @description Basically "request=GetCapabilities" as a neat data frame.
#' 
#' @details Lists all <FeatureType> nodes.
#'
#' @return data frame
#' 
#' @importFrom purrr flatten_dfc
#' @importFrom xml2 as_list xml_find_all xml_ns_strip
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#'
#' @export
get_feature_list <- function() {
  resp <- wfs_api(queries = "request=GetCapabilities")
  content <- resp$content
  
  # For some reason this seems to be a necessary step
  # for xml_find_all to function
  content_ns_strip <- xml2::xml_ns_strip(content)
  
  # All "<FeatureType>" nodes
  kaikki <- xml2::xml_find_all(content_ns_strip, "//FeatureType ")
  
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
#' @return feature Title (character)
#' 
#' @importFrom utils menu
#'
#' @author Pyry Kantanen <pyry.kantanen@@gmail.com>
#' 
#' @examples 
#' \dontrun{
#' selection <- select_feature()
#' feature <- get_feature(type_name = selected)
#' ggplot(feature) +
#'   geom_sf()
#' }
#'
#' @export
select_feature <- function() {
  df <- get_feature_list()
  unique_namespace <- unique(df$Namespace)
  selection <- menu(choices = unique_namespace,
                    title = "From which namespace?")
  selection2 <- menu(choices = df$Title[which(df$Namespace == unique_namespace[selection])],
                     title = "Which dataset?")
  selected_dataset <- df$Name[which(df$Title == df$Title[selection2])]
  selected_dataset
}
