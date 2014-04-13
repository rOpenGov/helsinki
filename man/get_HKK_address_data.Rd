\name{get_HKK_address_data}
\alias{get_HKK_address_data}
\title{Retrieve address information in Helsinki region}
\usage{
get_HKK_address_data(which.data = NULL, data.dir = tempdir())
}
\arguments{
  \item{which.data}{A string. Specify the name of the HKK
  data set to retrieve. Options: "Helsingin
  osoiteluettelo", "Seudullinen osoiteluettelo"}

  \item{data.dir}{Directory where the original downloaded
  raw data will be stored.}
}
\value{
A data frame containing the address data
}
\description{
Retrieves address data from Helsinki Real Estate Department
(Helsingin kaupungin kiinteistovirasto, HKK):
http://kartta.hel.fi/avoindata/index.html
}
\details{
The data (C) 2011 Helsingin kaupunkimittausosasto.
}
\examples{
tab <- get_HKK_address_data("Helsingin osoiteluettelo")
}
\author{
Juuso Parkkinen, Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

