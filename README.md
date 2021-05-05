
# helsinki - Helsinki open data R tools

<!-- badges: start -->

[![R build
status](https://github.com/rOpenGov/helsinki/workflows/R-CMD-check/badge.svg)](https://github.com/rOpenGov/helsinki/actions)
[![CRAN Status
Badge](http://www.r-pkg.org/badges/version/helsinki)](http://www.r-pkg.org/pkg/helsinki)
[![Downloads
total](http://cranlogs.r-pkg.org/badges/grand-total/helsinki)](https://cran.r-project.org/package=helsinki)
[![Downloads
monthly](http://cranlogs.r-pkg.org/badges/helsinki)](http://www.r-pkg.org/pkg/helsinki)
[![Watch on
GitHub](https://img.shields.io/github/watchers/ropengov/helsinki.svg?style=social)](https://github.com/ropengov/helsinki/watchers)
[![Star on
GitHub](https://img.shields.io/github/stars/ropengov/helsinki.svg?style=social)](https://github.com/ropengov/helsinki/stargazers)
[![Follow on
Twitter](https://img.shields.io/twitter/follow/ropengov.svg?style=social)](https://twitter.com/intent/follow?screen_name=ropengov)
<!--[![Stories in Ready](https://badge.waffle.io/ropengov/helsinki.png?label=Ready)](http://waffle.io/ropengov/helsinki)-->
<!--[![codecov.io](https://codecov.io/github/rOpenGov/helsinki/coverage.svg?branch=master)](https://codecov.io/github/rOpenGov/helsinki?branch=master)-->
<!-- badges: end -->

<!-- README.md is generated from README.Rmd. Please edit that file -->

R tools for accessing and downloading open data from the Helsinki
capital region in Finland.

### Installation

``` r
# Stable release
install.packages("helsinki")
# Development version
library(remotes)
remotes::install_github("ropengov/helsinki")
```

### Simple example

Load the package, list available features from HSY and download the 20th
feature from that list:

``` r
library(helsinki) 
url <- "https://kartta.hsy.fi/geoserver/wfs"

hsy_features <- get_feature_list(base.url = url)

get_feature(base.url = url, typename = hsy_features$Name[20])
```

For more examples, check the [tutorial
page](https://github.com/rOpenGov/helsinki/blob/master/vignettes/helsinki_tutorial.md).

### Meta

Authors: [Juuso Parkkinen](https://github.com/ouzor), [Joona
Lehtomäki](https://github.com/jlehtoma), [Pyry
Kantanen](https://github.com/pitkant), [Leo
Lahti](https://github.com/antagomir). Part of the
[rOpenGov](http://ropengov.org) project.

You are welcome to contact us:

-   [submit suggestions and
    bug-reports](https://github.com/ropengov/helsinki/issues)
-   [send a pull request](https://github.com/ropengov/helsinki/)
-   [be in touch](http://ropengov.org/community/) and follow us in
    social media
