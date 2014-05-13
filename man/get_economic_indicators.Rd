\name{get_economic_indicators}
\alias{get_economic_indicators}
\title{Retrieve economic indicators}
\usage{
get_economic_indicators(verbose = TRUE)
}
\arguments{
  \item{verbose}{logical. Should R report extra information
  on progress?}
}
\value{
results A list with indicator data as a data frame, and
additional metadata and notes provided in the original
data.
}
\description{
Retrieve economic indicators for the Helsinki region from
Helsinki Region Infoshare
http://www.hri.fi/fi/data/paakaupunkiseudun-kuntien-taloudellisia-tunnuslukuja/.
Helsinki, Espoo, Vantaa, Kauniainen, Finland, years
1998-2010.
}
\examples{
\dontrun{ res.list <- get_economic_indicators() }
}
\author{
Juuso Parkkinen \email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

