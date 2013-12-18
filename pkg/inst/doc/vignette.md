<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->

Helsinki  R tools
===========

This is an [rOpenGov](http://ropengov.github.com/helsinki) R package
providing tools for open Helsinki data.


### Installation

Release version for general users:


```r
install.packages("helsinki")
library(helsinki)
```


Development version for developers:


```r
install.packages("devtools")
library(devtools)
install_github("helsinki", "ropengov")
library(helsinki)
```


Further installation and development instructions at the [home
page](http://ropengov.github.com/helsinki).


### Examples

For further usage examples, see
[Louhos-blog](http://louhos.wordpress.com) and
[Datawiki](https://github.com/louhos/sorvi/wiki/Data), and
[takomo](https://github.com/louhos/takomo/tree/master/Helsinki).


### Licensing and Citations

This work can be freely used, modified and distributed under the
[Two-clause FreeBSD
license](http://en.wikipedia.org/wiki/BSD\_licenses). Cite Helsinki R
package and and the appropriate data provider, including a url
link. Kindly cite the R package as 'Leo Lahti, Juuso Parkkinen ja
Joona Lehtomäki (2013). helsinki R package. URL:
http://ropengov.github.io/helsinki)'.


### Session info


This vignette was created with


```r
sessionInfo()
```

```
## R version 3.0.1 (2013-05-16)
## Platform: x86_64-unknown-linux-gnu (64-bit)
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=C                 LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] helsinki_0.9.01 RCurl_1.95-4.1  bitops_1.0-5    rgdal_0.8-9    
## [5] sp_1.0-9        rjson_0.2.12    knitr_1.2      
## 
## loaded via a namespace (and not attached):
## [1] digest_0.6.3    evaluate_0.4.3  formatR_0.7     grid_3.0.1     
## [5] lattice_0.20-15 sorvi_0.4.14    stringr_0.6.2   tools_3.0.1
```


