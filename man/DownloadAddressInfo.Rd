\name{DownloadAddressInfo}
\alias{DownloadAddressInfo}
\title{Retrieve address information in Helsinki region}
\usage{
DownloadAddressInfo(which.data, data.dir = NULL)
}
\arguments{
  \item{which.data}{A string. Specify the name of the HKK
  data set to retrieve. Options: "Helsingin
  osoiteluettelo", "Seudullinen osoiteluettelo"}

  \item{data.dir}{Directory where the original downloaded
  raw data will be stored.}
}
\value{
List with the following elements: local.file (local file
name); local.path (download directory); source.url (url of
the original data file); time (date and time of data
download); which.data (data set to retrieve)
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
# tab <- GetAddressInfo("Helsingin osoiteluettelo")
}
\author{
Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

