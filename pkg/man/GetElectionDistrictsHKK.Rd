\name{GetElectionDistrictsHKK}
\alias{GetElectionDistrictsHKK}
\title{Retrieve Election District data
Retrieves Election District data from Helsinki Real Estate Department (Helsingin
kaupungin kiinteistovirasto, HKK) through the HKK website
http://kartta.hel.fi/avoindata/index.html}
\usage{
  GetElectionDistrictsHKK()
}
\arguments{
  \item{city}{Name the municipality for which to retrieve
  the election districts}
}
\value{
  a list of Shape objects (from SpatialPolygonsDataFrame
  class)
}
\description{
  The data (C) 2011 Helsingin kaupunkimittausosasto.
}
\examples{
# sp <- GetElectionDistrictsHKK()
}
\author{
  Joona Lehtomaki and Leo Lahti
  \email{louhos@googlegroups.com}
}
\references{
  See citation("helsinki")
}

