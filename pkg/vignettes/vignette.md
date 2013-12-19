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

## Helsinki Region Infoshare (HRI)

### Municipality maps (Aluejakokartat)

Get [Helsinki Region Infoshare](http://www.hri.fi) (HRI) municipality maps:


```r
# Load library http://ropengov.github.com/helsinki/
library(helsinki)

# Get the maps
pienalue <- GetHRIaluejakokartat()

# Inspect the data
head(pienalue$pienalue.df)
```

```
##    group  long   lat order  hole piece id        Name description
## 32     1 24.63 60.15     1 FALSE     1  1 Laurinlahti        <NA>
## 2      1 24.63 60.15     2 FALSE     1  1 Laurinlahti        <NA>
## 4      1 24.63 60.15     3 FALSE     1  1 Laurinlahti        <NA>
## 1      1 24.64 60.15     4 FALSE     1  1 Laurinlahti        <NA>
## 13     1 24.64 60.15     5 FALSE     1  1 Laurinlahti        <NA>
## 6      1 24.64 60.15     6 FALSE     1  1 Laurinlahti        <NA>
##    timestamp begin  end altitudeMode tessellate extrude visibility
## 32      <NA>  <NA> <NA>         <NA>         -1      -1         -1
## 2       <NA>  <NA> <NA>         <NA>         -1      -1         -1
## 4       <NA>  <NA> <NA>         <NA>         -1      -1         -1
## 1       <NA>  <NA> <NA>         <NA>         -1      -1         -1
## 13      <NA>  <NA> <NA>         <NA>         -1      -1         -1
## 6       <NA>  <NA> <NA>         <NA>         -1      -1         -1
##       KOKOTUN KUNTA SUUR TILA PIEN        Nimi    NIMI_ISO Mediaanihinta
## 32 0494041414   049    4   41  414 Laurinlahti LAURINLAHTI          2914
## 2  0494041414   049    4   41  414 Laurinlahti LAURINLAHTI          2914
## 4  0494041414   049    4   41  414 Laurinlahti LAURINLAHTI          2914
## 1  0494041414   049    4   41  414 Laurinlahti LAURINLAHTI          2914
## 13 0494041414   049    4   41  414 Laurinlahti LAURINLAHTI          2914
## 6  0494041414   049    4   41  414 Laurinlahti LAURINLAHTI          2914
##    Hinnat
## 32   3261
## 2    3261
## 4    3261
## 1    3261
## 13   3261
## 6    3261
```



## Helsinki region environmental services (Helsingin seudun ympäristöpalvelut HSY)


### Population grid

Download population information from [HSY database](http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx) ((C) 2011 HSY) and visualize on the Helsinki map. For data documentation, see [HSY website](http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf).



```r
# http://ropengov.github.com/helsinki
library(helsinki)

# Get population grid (Vaestoruudukko)
sp <- GetHSY("Vaestoruudukko")
```

```
## [1] "Vaestoruudukko_2010_region"
```

```r

# Define limits of the color scale
at <- c(seq(0, 2000, 250), Inf)

# Visualize population grid
q <- PlotShape(sp, "ASUKKAITA", type = "oneway", at = at, ncol = length(at))
```

```
## Error: could not find function "PlotShape"
```


The following data sets are available (specified in the GetHSY argument):

 * Vaestotietoruudukko: population size, density, and age structure per grid

 * Rakennustietoruudukko: Grid-level (500mx500m) information on
   building counts (lukumaara), area (kerrosala), usage
   (kayttotarkoitus), region efficiency (aluetehokkuus).

 * seutuRAMAVA: building area capacity per municipality region
   (kaupunginosittain summattu tieto rakennusmaavarannosta)



Inspect data manually. Some rarely populated grids are censored with
'99' to guarantee privacy.


```r
df <- as.data.frame(sp)
head(df)
```

```
##   INDEX ASUKKAITA ASVALJYYS IKA0_9 IKA10_19 IKA20_29 IKA30_39 IKA40_49
## 0  4325        60        40     99       99       99       99       99
## 1  4625        31        45     99       99       99       99       99
## 2  5025        25        51     99       99       99       99       99
## 3  5725         6        42     99       99       99       99       99
## 4  4226        21       101     99       99       99       99       99
## 5  4326        14        84     99       99       99       99       99
##   IKA50_59 IKA60_69 IKA70_79 IKA_YLI80
## 0       99       99       99        99
## 1       99       99       99        99
## 2       99       99       99        99
## 3       99       99       99        99
## 4       99       99       99        99
## 5       99       99       99        99
```



### Further HSY data

[HSY website](http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx) has data for 2010-2011. More is coming, add later and allow temporal analysis.

For further usage examples, see
[Louhos-blog](http://louhos.wordpress.com) and
[takomo](https://github.com/louhos/takomo/tree/master/Helsinki).


## Helsinki Real Estate Department (Helsingin kaupungin kiinteistövirasto, HKK)

Retrieve [HKK](http://kartta.hel.fi/avoindata/index.html) data sets.


```r
sp <- GetHKK("Aanestysaluejako", data.dir = ".")
```

```
## OGR data source with driver: MapInfo File 
## Source: "./aanestysalueet/PKS_aanestysalueet_kkj2.TAB", layer: "PKS_aanestysalueet_kkj2"
## with 291 features and 6 fields
## Feature type: wkbPolygon with 2 dimensions
```




### Licensing and Citations

This work can be freely used, modified and distributed under the
[Two-clause FreeBSD
license](http://en.wikipedia.org/wiki/BSD\_licenses). Cite Helsinki R
package and and the appropriate data provider, including a url
link. Kindly cite the R package as 'Leo Lahti, Juuso Parkkinen ja
Joona Lehtomäki (2013). helsinki R package. URL:
http://ropengov.github.io/helsinki'.


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
## [1] grid      stats     graphics  grDevices utils     datasets  methods  
## [8] base     
## 
## other attached packages:
##  [1] maptools_0.8-23 lattice_0.20-15 foreign_0.8-54  helsinki_0.9.02
##  [5] RCurl_1.95-4.1  bitops_1.0-5    rgdal_0.8-9     sp_1.0-9       
##  [9] rjson_0.2.12    knitr_1.2      
## 
## loaded via a namespace (and not attached):
## [1] digest_0.6.3   evaluate_0.4.3 formatR_0.7    sorvi_0.4.14  
## [5] stringr_0.6.2  tools_3.0.1
```


