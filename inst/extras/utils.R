# unzip.files <- function (data.dir, remote.zip, local.zip, data.url, which.data) {
# 
#     # Local zip location 
#     local.zip <- file.path(data.dir, remote.zip)
# 
#     # Create the web address from where to fetch the zip
#     data.url <- paste(data.url, remote.zip, sep = "")
#     message(paste("Dowloading HKK", which.data, " data from ", data.url, "in file", local.zip, ". Kindly cite the original data sources. For license and citation information, see http://kartta.hel.fi/avoindata/"))
#     download.file(data.url, destfile = local.zip)
# 
#     # Unzip the downloaded zip file
#     #data.dir <- file.path(data.dir, "aanestysalueet")
#     unzip(local.zip, exdir = data.dir)
# 
# }
# 
