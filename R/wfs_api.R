#' @title WFS API
#'
#' @description Requests to various WFS API.
#'
#' @details Make a request to the spesific WFS API. The base url is
#'    https://kartta.hsy.fi/geoserver/wfs to which other
#'    components defined by the arguments are appended.
#'    
#'    This is a low-level function intended to be used by other higher level
#'    functions in the package.
#' 
#' @source Gracefully failing HTTP request code (slightly adapted by Pyry 
#'    Kantanen) from RStudio community member kvasilopoulos. Many thanks!
#'    
#'    Source of the original RStudio community discussion:
#'    \url{https://community.rstudio.com/t/internet-resources-should-fail-gracefully/49199}
#'
#' @param base.url WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"
#' @param queries List of query parameters
#' @param timeout.s timeout in seconds, passed onto [gracefully_fail()]
#'
#' @return wfs_api (S3) object with the following attributes:
#'        \describe{
#'           \item{content}{XML payload.}
#'           \item{path}{path provided to get the resonse.}
#'           \item{response}{the original response object.}
#'         }
#'
#' @author Joona Lehtomäki <joona.lehtomaki@@iki.fi>, Kostas Vasilopoulos,
#'    Pyry Kantanen
#'
#' @examples
#'   wfs_api(base.url = "https://kartta.hsy.fi/geoserver/wfs", 
#'           queries = c("service" = "WFS", 
#'           "version" = "1.0.0", 
#'           "request" = "getFeature", 
#'           "typeName" = "ilmanlaatu:Ilmanlaatu_nyt")
#'           )
#'                      
#' @importFrom xml2 read_xml xml_text xml_has_attr xml_children
#' @importFrom httr GET timeout user_agent modify_url http_error message_for_status
#' @importFrom curl has_internet
#'                      
#' @export
wfs_api <- function(base.url = NULL, queries, timeout.s = NULL) {

  if (is.null(base.url)) {
    stop("base.url = NULL. Please input a valid WFS url")
  }

  if (!grepl("^http", base.url)) {
    stop("Invalid base URL")
  }

  if (is.null(names(queries))) {
    message("Please input the list in name-value pairs: c(\"name1\" = \"value1\", \"name2\" = \"value2\", ...)")
    invisible(return(NULL))
  }

  # Test if queries is a named "Named num" or "Named chr" vector
  if (is.vector(queries, mode = "character") || is.vector(queries, mode = "numeric")) {
    queries <- as.list(queries)
  }

  if (!is.list(queries)) {
    message("Please input the list in name-value pairs: c(\"name1\" = \"value1\", \"name2\" = \"value2\", ...)")
    invisible(return(NULL))
  }

  # Set the user agent
  ua <- httr::user_agent("https://github.com/rOpenGov/helsinki")
  
  # Construct the query URL
  url <- httr::modify_url(base.url, query = queries)
  
  # Print out the URL
  message("Requesting response from: ", url)
  
  graceful_result <- gracefully_fail(url, timeout.s = NULL)
  
  if (is.null(graceful_result)) {
    message("Please check your settings or function parameters \n")
    return(invisible(NULL))
  }
  
  # Get the response and check the response.
  resp <- httr::GET(url, ua)
  
  # Parse the response XML content
  content <- xml2::read_xml(resp$content)
  
  # Object for checking exceptions
  content_child <- xml2::xml_children(content)
  truth_table <- vapply(X = content_child, 
                        FUN = xml2::xml_has_attr,
                        FUN.VALUE = logical(1),
                        "exceptionCode")
  
  # Even if GET and read_xml work properly, content can be unusable
  if (any(truth_table)) {
    message(paste("Please check your download parameters.", 
                  "Detected following exception(s):\n", 
                  xml2::xml_text(content)))
    return(invisible(NULL))
  }
  
  api_obj <- structure(
    list(
      url = url,
      response = resp
    ),
    class = "wfs_api"
  )

  # Attach the nodes to the API object
  api_obj$content <- content
  
  return(api_obj)
}

#' @title Gracefully fail internet resources
#' 
#' @description Function for gracefully failing internet resources
#' 
#' @author Kostas Vasilopoulos
#' 
#' @source Gracefully failing HTTP request code (slightly adapted by Pyry 
#'    Kantanen) from RStudio community member kvasilopoulos. Many thanks!
#'    
#'    Source of the original RStudio community discussion:
#'    \url{https://community.rstudio.com/t/internet-resources-should-fail-gracefully/49199}
#' 
#' @importFrom httr GET http_error message_for_status
#' @importFrom curl has_internet
#' 
#' @keywords internal
gracefully_fail <- function(remote.file, timeout.s = NULL) {
  
  if (is.null(timeout.s)) {timeout.s <- 10}
  
  try_GET <- function(x, ...) {
    tryCatch(
      httr::GET(url = x, timeout(timeout.s), ...),
      error = function(e) conditionMessage(e),
      warning = function(w) conditionMessage(w)
    )
  }
  
  is_response <- function(x) {
    class(x) == "response"
  }
  
  # First check internet connection
  if (!curl::has_internet()) {
    message("No internet connection")
    return(invisible(NULL))
  }
  # Then try for timeout problems
  resp <- try_GET(remote.file)
  if (!is_response(resp)) {
    message(resp)
    return(invisible(NULL))
  }
  # Then stop if status > 400
  if (httr::http_error(resp)) { 
    httr::message_for_status(resp)
    message("\n")
    return(invisible(NULL))
  }
  
  x <- "all ok"
  invisible(x)
}
