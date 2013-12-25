\name{GetHelsinkiBuildingRegistry}
\alias{GetHelsinkiBuildingRegistry}
\title{Retrieve HKK data: Helsingin kaupungin rakennusrekisterin ote}
\usage{
  GetHelsinkiBuildingRegistry(which.data)
}
\arguments{
  \item{which.data}{A string. Specify the name of the data
  set to retrieve.}
}
\value{
  a list of Shape objects (from SpatialPolygonsDataFrame
  class)
}
\description{
  Retrieves data from Helsinki Real Estate Department
  (Helsingin kaupungin kiinteistovirasto, HKK) through the
  HKK website http://kartta.hel.fi/avoindata/index.html
}
\details{
  The data (C) 2011 Helsingin kaupunkimittausosasto.
}
\examples{
# tab <- GetHKK("Helsingin osoiteluettelo")
}
\author{
  Leo Lahti \email{louhos@googlegroups.com}
}
\references{
  See citation("helsinki")
}

