---
title: 'helsinki - Helsinki open data R tools'
output: 
  html_document: 
    keep_md: yes
---
  


helsinki - Helsinki open data R tools
========
  
<!-- badges: start -->
[![R build status](https://github.com/rOpenGov/helsinki/workflows/R-CMD-check/badge.svg)](https://github.com/rOpenGov/helsinki/actions)
[![CRAN Status Badge](http://www.r-pkg.org/badges/version/helsinki)](http://www.r-pkg.org/pkg/helsinki)
[![Downloads total](http://cranlogs.r-pkg.org/badges/grand-total/helsinki)](https://cran.r-project.org/package=helsinki)
[![Downloads monthly](http://cranlogs.r-pkg.org/badges/helsinki)](http://www.r-pkg.org/pkg/helsinki)
[![Watch on GitHub][github-watch-badge]][github-watch]
[![Star on GitHub][github-star-badge]][github-star]
[![Follow on Twitter](https://img.shields.io/twitter/follow/ropengov.svg?style=social)](https://twitter.com/intent/follow?screen_name=ropengov)
<!--[![Stories in Ready](https://badge.waffle.io/ropengov/helsinki.png?label=Ready)](http://waffle.io/ropengov/helsinki)-->
<!--[![codecov.io](https://codecov.io/github/rOpenGov/helsinki/coverage.svg?branch=master)](https://codecov.io/github/rOpenGov/helsinki?branch=master)-->
<!-- badges: end -->
  
<!-- README.md is generated from README.Rmd. Please edit that file -->
  
R tools for accessing and downloading open data from the Helsinki capital region in Finland. 
 
### Installation


```r
install.packages("helsinki")
```

### Simple example

List available features from HSY:
  
  
  ```r
  library(helsinki) 
  hsy_features <- dat <- get_feature_list(base.url = "https://kartta.hsy.fi/geoserver/wfs")
  ```

For further usage instructions, check the [tutorial page](https://github.com/rOpenGov/helsinki/blob/master/vignettes/helsinki_tutorial.md). 

Authors: [Juuso Parkkinen](https://github.com/ouzor), [Joona Lehtomäki](https://github.com/jlehtoma), [Pyry Kantanen](https://github.com/pitkant), [Leo Lahti](https://github.com/antagomir). Part of the [rOpenGov](http://ropengov.org) project.

You are welcome to contact us:
  
  * [submit suggestions and bug-reports](https://github.com/ropengov/helsinki/issues)
* [send a pull request](https://github.com/ropengov/helsinki/)
* [be in touch](http://ropengov.org/community/) and follow us in social media

[github-watch-badge]: https://img.shields.io/github/watchers/ropengov/helsinki.svg?style=social
[github-watch]: https://github.com/ropengov/helsinki/watchers
[github-star-badge]: https://img.shields.io/github/stars/ropengov/helsinki.svg?style=social
[github-star]: https://github.com/ropengov/helsinki/stargazers
