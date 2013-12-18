\name{GetOmakaupunki}
\alias{GetOmakaupunki}
\title{Access Omakaupunki data}
\usage{
  GetOmakaupunki(query, login, password, api_key, ...)
}
\arguments{
  \item{query}{API query, e.g. "event" or "directory"
  (services)}

  \item{login}{Personal username (required)}

  \item{password}{Personal password (required)}

  \item{api_key}{Personal API key (required)}

  \item{...}{Additional parameters to the API (optional).
  See details from the API documentation The data is
  licensed under CC BY-NC-SA 3.0.}
}
\value{
  List of results
}
\description{
  Access Omakaupunki data through the API. Using the API
  requireds a password and an API key. For more details and
  API documentation see
  http://blogit.hs.fi/hsnext/omakaupungin-meno-ja-palvelutiedot-avoimena-rajapintana
}
\examples{
# event.categories <- GetOmakaupunki("event/categories", LOGIN, PASSWORD, API)
}
\author{
  Juuso Parkkinen \email{louhos@googlegroups.com}
}

