\name{get_hsy}
\alias{get_hsy}
\title{Retrieve data from Helsinki Region Environmental Services}
\usage{
get_hsy(which.data = NULL, which.year = 2013, data.dir = tempdir())
}
\arguments{
  \item{which.data}{A string. Specify the name of the
  retrieved HSY data set. Options: Vaestotietoruudukko;
  Rakennustietoruudukko; SeutuRAMAVA_kosa;
  SeutuRAMAVA_tila. These are documented in HSY data
  description document (see above).}

  \item{which.year}{An integer. Specify the year for the
  data to be retrieved.}

  \item{data.dir}{A string. Specify a temporary folder for
  storing downloaded data.}
}
\value{
Shape object (from SpatialPolygonsDataFrame class)
}
\description{
Retrieves data from Helsinki Region Environmental Services
Authority (Helsingin seudun ymparistopalvelu HSY)
http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx
For data description (in Finnish) see:
http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf.
The data copyright (C) HSY 2011.
}
\examples{
sp <- get_hsy("Vaestotietoruudukko")
}
\author{
Juuso Parkkinen and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}
\keyword{utilities}

