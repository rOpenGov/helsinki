\name{get_hri_stats}
\alias{get_hri_stats}
\title{Helsinki Region Infoshare statistics API}
\usage{
get_hri_stats(query = "", verbose = TRUE)
}
\arguments{
  \item{query}{A string, specifying the dataset to query}

  \item{verbose}{logical. Should R report extra information
  on progress?}
}
\value{
results A three-dimensional array of results.
}
\description{
Retrieves data from the Helsinki Region Infoshare (HRI)
statistics API: http://dev.hel.fi/stats/. Currently
provides access to the 'aluesarja't data:
http://www.aluesarjat.fi/.
}
\details{
Current implementation is very simple. You can either get
the list of resources with query="", or query for a
specific resources and retrieve it in a three-dimensional
array form.
}
\examples{
# res.array <- get_hri_stats("aluesarjat_a03s_hki_vakiluku_aidinkieli")
}
\author{
Juuso Parkkinen \email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

