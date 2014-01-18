<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->

Helsinki  R tools
===========

The helsinki R package is part of the
[rOpenGov](http://ropengov.github.com/helsinki) project.


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


## Helsinki region environmental services (Helsingin seudun ympäristöpalvelut HSY)



### Population grid

Download population information from [HSY database](http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx) ((C) 2011 HSY) and visualize on the Helsinki map. For data documentation, see [HSY website](http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf). Population size, density, and age structure per grid.


```r
# http://ropengov.github.com/helsinki
library(helsinki)
```

```
## Error: package or namespace load failed for 'helsinki'
```

```r

# Get population grid (Vaestoruudukko)
sp <- GetHSY("Vaestoruudukko")
```

```
## Error: could not find function "GetHSY"
```

```r

# Visualize population grid library(gisfi) Define limits of the color
# scale at <- c(seq(0, 2000, 250), Inf) q <- PlotShape(sp, 'ASUKKAITA',
# type = 'oneway', at = at, ncol = length(at))
```


Inspect data manually. Some rarely populated grids are censored with
'99' to guarantee privacy.


```r
df <- as.data.frame(sp)
```

```
## Error: object 'sp' not found
```

```r
head(df)
```

```
##                                                   
## 1 function (x, df1, df2, ncp, log = FALSE)        
## 2 {                                               
## 3     if (missing(ncp))                           
## 4         .External(C_df, x, df1, df2, log)       
## 5     else .External(C_dnf, x, df1, df2, ncp, log)
## 6 }
```


### Helsinki building information

Information of buildings in Helsinki region. Data obtained from (C)
HSY 2011. Grid-level (500mx500m) information on building counts
(lukumaara), built area (kerrosala), usage (kayttotarkoitus), region
efficiency (aluetehokkuus).


```r
sp <- GetHSY("Rakennustietoruudukko")
```

```
## Error: could not find function "GetHSY"
```

```r
df <- as.data.frame(sp)
```

```
## Error: object 'sp' not found
```

```r
head(df)
```

```
##                                                   
## 1 function (x, df1, df2, ncp, log = FALSE)        
## 2 {                                               
## 3     if (missing(ncp))                           
## 4         .External(C_df, x, df1, df2, log)       
## 5     else .External(C_dnf, x, df1, df2, ncp, log)
## 6 }
```


### Helsinki building area capacity

Building area capacity per municipal region (kaupunginosittain summattu tieto rakennusmaavarannosta). Data obtained from (C) HSY 2011. 


```r
sp <- GetHSY("seutuRAMAVA")
```

```
## Error: could not find function "GetHSY"
```

```r
df <- as.data.frame(sp)
```

```
## Error: object 'sp' not found
```

```r
head(df)
```

```
##                                                   
## 1 function (x, df1, df2, ncp, log = FALSE)        
## 2 {                                               
## 3     if (missing(ncp))                           
## 4         .External(C_df, x, df1, df2, log)       
## 5     else .External(C_dnf, x, df1, df2, ncp, log)
## 6 }
```


### Building category codes

Mapping for building categories from the HSY documentation. Data obtained manually from (C) HSY 2011. 


```r
df <- GetHSY("key.KATAKER")
```

```
## Error: could not find function "GetHSY"
```

```r
head(df)
```

```
##                                                   
## 1 function (x, df1, df2, ncp, log = FALSE)        
## 2 {                                               
## 3     if (missing(ncp))                           
## 4         .External(C_df, x, df1, df2, log)       
## 5     else .External(C_dnf, x, df1, df2, ncp, log)
## 6 }
```


### Further HSY data

[HSY website](http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx) has data for 2010-2011. More is coming, add later and allow temporal analysis.


## Helsinki Real Estate Department (Helsingin kaupungin kiinteistövirasto, HKK)

Retrieve [HKK](http://kartta.hel.fi/avoindata/index.html) data sets.

### Helsinki address information


```r
res <- DownloadAddressInfo("Helsingin osoiteluettelo")
```

```
## Error: could not find function "DownloadAddressInfo"
```

```r
dat <- GetAddressInfo(res$local.file)
```

```
## Error: could not find function "GetAddressInfo"
```

```r
head(dat)
```

```
## Error: object 'dat' not found
```



```r
res <- DownloadAddressInfo("Seudullinen osoiteluettelo")
```

```
## Error: could not find function "DownloadAddressInfo"
```

```r
dat <- GetAddressInfo(res$local.file)
```

```
## Error: could not find function "GetAddressInfo"
```

```r
head(dat)
```

```
## Error: object 'dat' not found
```



### Licensing and Citations

This work can be freely used, modified and distributed under the
[Two-clause FreeBSD
license](http://en.wikipedia.org/wiki/BSD\_licenses). Cite Helsinki R
package and and the appropriate data provider, including a url
link. Kindly cite the R package as 'Leo Lahti, Juuso Parkkinen ja
Joona Lehtomäki (2013-2014). helsinki R package. URL:
http://ropengov.github.io/helsinki'.

For further usage examples, see
[Louhos-blog](http://louhos.wordpress.com) and
[takomo](https://github.com/louhos/takomo/tree/master/Helsinki).


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
## [1] RCurl_1.95-4.1 bitops_1.0-5   rjson_0.2.12   knitr_1.2     
## 
## loaded via a namespace (and not attached):
##  [1] digest_0.6.3    evaluate_0.4.3  formatR_0.7     grid_3.0.1     
##  [5] lattice_0.20-15 rgdal_0.8-9     sorvi_0.4.22    sp_1.0-9       
##  [9] stringr_0.6.2   tools_3.0.1
```


