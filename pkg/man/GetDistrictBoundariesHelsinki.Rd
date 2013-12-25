\name{GetDistrictBoundariesHelsinki}
\alias{GetDistrictBoundariesHelsinki}
\title{Retrieve District Boundaries in Helsinki}
\usage{
  GetDistrictBoundariesHelsinki(map)
}
\arguments{
  \item{map}{A string. Specify the name of the Helsinki
  District Boundary data set to retrieve. Available
  options: kunta, pienalue, pienalue_piste, suuralue,
  suuralue_piste, tilastoalue, tilastoalue_piste,
  aluejako_alueet_ja_pisteet (the last one gives all maps
  in a single list of shape objects)}
}
\value{
  a list of Shape objects (from SpatialPolygonsDataFrame
  class)
}
\description{
  Retrieves District Boundaries data (Aluejakorajat) from
  Helsinki Real Estate Department (Helsingin kaupungin
  kiinteistovirasto, HKK) through the HKK website
  http://kartta.hel.fi/avoindata/index.html
}
\details{
  The data (C) 2011 Helsingin kaupunkimittausosasto.
}
\examples{
# sp <- GetDistrictBoundariesHelsinki("tilastoalue");
          # pdf("~/tmp/tmp.pdf"); PlotShape(sp, "Name"); dev.off()
}
\author{
  Joona Lehtomaki and Leo Lahti
  \email{louhos@googlegroups.com}
}
\references{
  See citation("helsinki")
}

