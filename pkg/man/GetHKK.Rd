\name{GetHKK}
\alias{GetHKK}
\title{Retrieve HKK data}
\usage{
  GetHKK(which.data, data.dir)
}
\arguments{
  \item{which.data}{A string. Specify the name of the HKK
  data set to retrieve. Currently available options:
  Aluejakokartat;Aanestysaluejako;Seutukartta
  Rakennustietoruudukko; SeutuRAMAVA; key.KATAKER.}

  \item{data.dir}{A string. Specify the path where to save
  the downloaded data. A new subdfolder "aanestysalueet"
  will be created.}
}
\value{
  a list of Shape objects (from SpatialPolygonsDataFrame
  class)
}
\description{
  This script retrieves data from Helsinki Real Estate
  Department (Helsingin kaupunki kiinteistovirasto HKK)
  through the HKK website
  http://kartta.hel.fi/avoindata/index.html For details,
  see the HKK website
}
\details{
  The data copyright is on Helsingin kaupunkimittausosasto
  (C) 2011.
}
\examples{
# sp <- GetHKK("Aanestysaluejako", data.dir="C:/data")
}
\author{
  Joona Lehtomaki \email{louhos@googlegroups.com}
}
\references{
  See citation("sorvi")
}

