\name{get_servicemap}
\alias{get_servicemap}
\title{Access Helsinki region Service Map data}
\usage{
get_servicemap(category, ...)
}
\arguments{
  \item{category}{API query category, e.g. "service"}

  \item{...}{Additional parameters to the API (optional).
  See details from the API documentation}
}
\value{
List of results
}
\description{
Access Helsinki region Service Map (Paakaupunkiseudun
Palvelukartta) data from the its API (version 2). Using the
API is free. For more details and API documentation see
http://www.hel.fi/palvelukarttaws/rest/ver2.html. For
licensing terms pf the data see
http://www.hel2.fi/palvelukartta/REST.html.
}
\examples{
pk.services <- get_servicemap("service")
}
\author{
Juuso Parkkinen \email{louhos@googlegroups.com}
}

