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
#'    Note that GET requests are used using `httpcache` meaning that requests
#'    are cached. If you want clear cache, use [httpcache::clearCache()]. To 
#'    turn the cache off completely, use [httpcache::cacheOff()]
#' 
#' @source Gracefully failing HTTP request code (slightly adapted by Pyry 
#'    Kantanen) from RStudio community member kvasilopoulos. Many thanks!
#'    
#'    Source of the original RStudio community discussion:
#'    \url{https://community.rstudio.com/t/internet-resources-should-fail-gracefully/49199}
#'
#' @param base.url WFS url, for example "https://kartta.hsy.fi/geoserver/wfs"
#' @param queries List of query parameters
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
#'           queries = append(list("service" = "WFS", "version" = "1.0.0"), 
#'                 list(request = "getFeature", 
#'                      layer = "tilastointialueet:kunta4500k_2017")))
#'                      
#' @importFrom xml2 read_xml xml_text xml_has_attr xml_children
#' @importFrom httpcache GET
#' @importFrom httr timeout user_agent modify_url http_error message_for_status
#' @importFrom curl has_internet
#'                      
#' @export
wfs_api <- function(base.url = NULL, queries) {
  
  if (is.null(base.url)) {
    stop("base.url = NULL. Please input a valid WFS url")
  }
  
  if (!grepl("^http", base.url)) {
    stop("Invalid base URL")
  }
  
  # Set the user agent
  ua <- httr::user_agent("https://github.com/rOpenGov/helsinki")
  
  # Construct the query URL
  url <- httr::modify_url(base.url, query = queries)
  
  # Print out the URL
  message("Requesting response from: ", url)
  
  # Following code snippet from RStudio Community contributor kvasilopoulos
  # See function help for more details ________________________________________
  try_GET <- function(x, ...) {
    tryCatch(
      GET(url = x, httr::timeout(10), ...),
      error = function(e) conditionMessage(e),
      warning = function(w) conditionMessage(w)
    )
  }
  is_response <- function(x) {
    class(x) == "response"
  }
  
  # First check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }
  # Then try for timeout problems
  resp <- try_GET(url)
  if (!is_response(resp)) {
    message(resp)
    return(invisible(NULL))
  }
  # Then stop if status > 400
  if (httr::http_error(resp)) { 
    httr::message_for_status(resp)
    return(invisible(NULL))
  }
  # Many thanks! ______________________________________________________________
  
  # Get the response and check the response.
  resp <- httpcache::GET(url, ua)
  
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
    warning(paste("Please check your download parameters.", 
                  "Detected following exception(s):\n", 
                  xml2::xml_text(content)))
    # return(invisible(NULL))
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
