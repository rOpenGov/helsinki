#' Install marginal dependencies on-demand from other functions.
#' 
#' Function is always supposed to be called from a parent function and if the
#' marginal depedency package is not installed, the function will report the 
#' name of the parent function requiring the package. Note that the whole call
#' stack is not reported, only the immediate parent.
#'
#' @param package String name for the name to be installed
#' @param ... further arguments passed on to install.packages
#'
#' @return Invisible NULL
#' 
#' @note meant for package internal use only
#' @export
#' @author Joona Lehtomaki \email{louhos@@googlegroups.com}
#' @keywords utilities

.InstallMarginal <- function(package, ...) {
  if (suppressWarnings(!require(package, character.only=TRUE, quietly=TRUE))) { 
    parent.function <- sys.calls()[[1]][1]
    message(paste("Function ", parent.function, " requires package: ", package,
                  ". Package not found, installing...", sep=""))
    install.packages(package, ...) # Install the packages
    # Remember to load the library after installation
    require(package, character.only=TRUE) 
  }
}

