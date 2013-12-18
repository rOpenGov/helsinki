\name{GetHSY}
\alias{GetHSY}
\alias{get.hsy}
\title{Retrieve HSY data}
\usage{
  GetHSY(which.data = "Vaestoruudukko")
}
\arguments{
  \item{which.data}{A string. Specify the name of the HSY
  data set to retrieve. Currently available options:
  Vaestoruudukko; Rakennustietoruudukko; SeutuRAMAVA;
  key.KATAKER. The first three are documented in HSY data
  description document (see above). The key.KATAKER
  contains manually parsed mapping for building categories
  from the HSY documentation.}
}
\value{
  Shape object (from SpatialPolygonsDataFrame class)
}
\description{
  This script retrieves data from Helsinki Region
  Environmental Services Authority (Helsingin seudun
  ymparistopalvelu HSY) through the HSY website
  http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx
  For details, see the HSY website, in particular the data
  description (in Finnish) at:
  http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf.
  The data copyright is on (C) HSY 2011.
}
\examples{
# sp <- get.hsy("Vaestoruudukko")
}
\author{
  Leo Lahti \email{louhos@googlegroups.com}
}
\references{
  See citation("sorvi")
}
\keyword{utilities}

