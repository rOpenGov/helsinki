\name{GetHSY}
\alias{GetHSY}
\title{Retrieve HSY data}
\usage{
  GetHSY(which.data = "Vaestoruudukko")
}
\arguments{
  \item{which.data}{A string. Specify the name of the
  retrieved HSY data set. Options: Vaestoruudukko;
  Rakennustietoruudukko; SeutuRAMAVA; key.KATAKER. The
  first three are documented in HSY data description
  document (see above). The key.KATAKER contains manually
  parsed mapping for building categories from the HSY
  documentation.}
}
\value{
  Shape object (from SpatialPolygonsDataFrame class)
}
\description{
  Retrieves data from Helsinki Region Environmental
  Services Authority (Helsingin seudun ymparistopalvelu
  HSY)
  http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx
  For data description (in Finnish) see:
  http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf.
  The data copyright (C) HSY 2011.
}
\details{
  Arguments:
}
\examples{
# sp <- get.hsy("Vaestoruudukko")
}
\author{
  Leo Lahti \email{louhos@googlegroups.com}
}
\references{
  See citation("helsinki")
}
\keyword{utilities}

