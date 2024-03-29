% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/HSY.R
\name{get_rakennustietoruudukko}
\alias{get_rakennustietoruudukko}
\title{Produce an SF object: Rakennustietoruudukko}
\usage{
get_rakennustietoruudukko(year = NULL)
}
\arguments{
\item{year}{year as numeric between 1997-1998 and 2009-2021.
If NULL (default), the function will return the latest available dataset.}
}
\value{
sf object
}
\description{
Produces an sf object for Rakennustietoruudukko (building
information grid).
}
\details{
Additional data not available here can be manually downloaded from
HRI website: \url{https://hri.fi/data/fi/dataset/rakennustietoruudukko}

Years 2015-2021 are tested to work at the time of development.
Additional years may be added in the future and older datasets may be removed
from the API. Datasets from years 2015-2021 are downloaded from HSY WFS API and datasets
for other years are downloaded as zip files from HRI website. The format of
the output might be a bit different between datasets downloaded from the WFS
API and datasets downloaded from HRI website.

Additional years may be added in the future and older datasets may be removed
from the API. See package NEWS for more information.

The current datasets can be listed with \code{\link[=get_feature_list]{get_feature_list()}}
or \code{\link[=select_feature]{select_feature()}}.
}
\examples{
\dontrun{
building_grid <- get_rakennustietoruudukko(year = 2021)
}

}
\author{
Pyry Kantanen \href{mailto:pyry.kantanen@gmail.com}{pyry.kantanen@gmail.com}
}
