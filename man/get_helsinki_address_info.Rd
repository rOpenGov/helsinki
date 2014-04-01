\name{get_helsinki_address_info}
\alias{get_helsinki_address_info}
\title{Retrieve address information in Helsinki region}
\usage{
get_helsinki_address_info(which.data, data.dir = tempdir())
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
# tab <- get_helsinki_address_info("Helsingin osoiteluettelo")
}
\author{
Juuso Parkkinen, Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

