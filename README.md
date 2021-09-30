
<!-- README.md is generated from README.Rmd. Please edit that file -->

# helsinki - Helsinki open data R tools <a href="https://ropengov.github.io/hetu/"><img src="man/figures/logo.png" align="right" height="139"/></a>

<!-- badges: start -->

[![rOG-badge](https://ropengov.github.io/rogtemplate/reference/figures/ropengov-badge.svg)](http://ropengov.org/)
[![R build
status](https://github.com/rOpenGov/helsinki/workflows/R-CMD-check/badge.svg)](https://github.com/rOpenGov/helsinki/actions)
[![CRAN Status
Badge](https://www.r-pkg.org/badges/version/helsinki)](https://www.r-pkg.org/pkg/helsinki)
[![Codecov test
coverage](https://codecov.io/gh/rOpenGov/helsinki/branch/master/graph/badge.svg)](https://codecov.io/gh/rOpenGov/helsinki?branch=master)
[![Downloads
total](http://cranlogs.r-pkg.org/badges/grand-total/helsinki)](https://cran.r-project.org/package=helsinki)
[![Downloads
monthly](https://cranlogs.r-pkg.org/badges/helsinki)](https://www.r-pkg.org/pkg/helsinki)
[![Watch on
GitHub](https://img.shields.io/github/watchers/ropengov/helsinki.svg?style=social)](https://github.com/ropengov/helsinki/watchers)
[![Star on
GitHub](https://img.shields.io/github/stars/ropengov/helsinki.svg?style=social)](https://github.com/ropengov/helsinki/stargazers)
[![Follow on
Twitter](https://img.shields.io/twitter/follow/ropengov.svg?style=social)](https://twitter.com/intent/follow?screen_name=ropengov)
<!-- badges: end -->

The goal of helsinki package is to provide tools in R to access and
download open data from City of Helsinki and the Helsinki metropolitan
area - the Finnish capital region.

## Installation

You can install the released version of helsinki from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("helsinki")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes)
library(remotes)
remotes::install_github("ropengov/helsinki")
```

## Using the package

Loading the package:

``` r
library(helsinki)
```

List available features from Helsinki Region Environmental Services HSY
WFS API and then download the 15th feature from that list:

``` r
url <- "https://kartta.hsy.fi/geoserver/wfs"
hsy_features <- get_feature_list(base.url = url)
get_feature(base.url = url, typename = hsy_features$Name[15])
```

For more examples, check the [tutorial
page](http://ropengov.github.io/helsinki/articles/helsinki_tutorial.html).

### Contributing

You are welcome to contact us:

-   [Submit suggestions and bug
    reports](https://github.com/ropengov/helsinki/issues) (provide the
    output of `sessionInfo()` and `packageVersion("helsinki")` and
    preferably provide a [reproducible
    example](http://adv-r.had.co.nz/Reproducibility.html))
-   [Send a pull request](https://github.com/ropengov/helsinki/)
-   [Star us on the Github page](https://github.com/ropengov/helsinki/)
-   [See our website](http://ropengov.org/community/) for additional
    contact information

### Acknowledgements

**Kindly cite this work** as follows: [Juuso
Parkkinen](https://github.com/ouzor), [Joona
Lehtomäki](https://github.com/jlehtoma), [Pyry
Kantanen](https://github.com/pitkant), and [Leo
Lahti](https://github.com/antagomir). helsinki - Helsinki open data R
tools. URL: <http://ropengov.github.io/helsinki/>

We are grateful to all
[contributors](https://github.com/rOpenGov/helsinki/graphs/contributors)!
This project is part of [rOpenGov](http://ropengov.org).
