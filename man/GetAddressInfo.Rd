\name{GetAddressInfo}
\alias{GetAddressInfo}
\title{Retrieve address information in Helsinki region}
\usage{
GetAddressInfo(local.file)
}
\arguments{
  \item{local.file}{A filename pointing to the downloaded
  data, either "Helsingin osoiteluettelo" or "Seudullinen
  osoiteluettelo"}
}
\value{
data frame
}
\description{
Retrieves address data from Helsinki Real Estate Department
(Helsingin kaupungin kiinteistovirasto, HKK):
http://kartta.hel.fi/avoindata/index.html
}
\details{
The data (C) 2011 Helsingin kaupunkimittausosasto.
}
\examples{
# res <- DownloadAddressInfo("Helsingin osoiteluettelo"); dat <- GetAddressInfo( res$local.file )
}
\author{
Leo Lahti \email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

