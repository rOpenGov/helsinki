\name{get_HSY_data}
\alias{get_HSY_data}
\title{Retrieve HSY data}
\usage{
get_HSY_data(which.data = NULL, which.year = 2013, data.dir = tempdir())
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
\details{
Arguments:
}
\examples{
# sp <- get_HSY_data("Vaestoruudukko")
}
\author{
Juuso Parkkinen and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}
\keyword{utilities}

