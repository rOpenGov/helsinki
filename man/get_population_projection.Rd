\name{get_population_projection}
\alias{get_population_projection}
\title{Retrieve population projection data}
\usage{
get_population_projection(verbose = TRUE)
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
Retrieve population projection data (vaestoennuste) by age
and gender from Helsinki Region Infoshare
http://www.hri.fi/fi/data/helsingin-ja-helsingin-seudun-vaestoennuste-sukupuolen-ja-ian-mukaan-2012-2050/
Helsinki, Helsinki region, 2012-2050
}
\examples{
res.list <- get_population_projection()
}
\author{
Juuso Parkkinen \email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

