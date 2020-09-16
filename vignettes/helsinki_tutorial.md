---
title: "Helsinki open data R tools"
date: "2020-09-16"
output: 
  rmarkdown::html_vignette:
    toc: true
vignette: >
  %\VignetteIndexEntry{Helsinki open data R tools}
  %\VignetteEngine{knitr::rmarkdown}
  \usepackage[utf8]{inputenc}
---





helsinki - tutorial
===========

This R package provides tools to access open data from the Helsinki region in Finland
as part of the [rOpenGov](http://ropengov.github.io) project.

For contact information and source code, see the [github page](https://github.com/rOpenGov/helsinki). 

## Available data sources

[Helsinki region district maps](#aluejakokartat) (Helsingin seudun aluejakokartat)

* Aluejakokartat: kunta, pien-, suur-, tilastoalueet (Helsinki region district maps)
* Äänestysaluejako: (Helsinki region election district maps)
* Source: [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/)

Helsinki Real Estate Department (HKK:n avointa dataa)

* Spatial data from [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/) availabe in the [gisfin](https://github.com/rOpenGov/gisfin) package, see [gisfin tutorial](https://github.com/rOpenGov/gisfin/blob/master/vignettes/gisfin_tutorial.md) for examples

[Helsinki region environmental services](#hsy) (HSY:n avointa dataa)

* Väestötietoruudukko (population grid)
* Rakennustietoruudukko (building information grid)
* SeutuRAMAVA (building land resource information(?))
* Source: Helsingin seudun ympäristöpalvelut, HSY

[Service and event information](#servicemap)

* [Helsinki region Service Map API](http://api.hel.fi/servicemap/v1/) (Pääkaupunkiseudun Palvelukartta)
* [Helsinki Linked Event API](http://api.hel.fi/linkedevents/v0.1/)

[Helsinki Region Infoshare statistics API](#hri_stats)

* [Aluesarjat (original source)](http://www.aluesarjat.fi/) (regional time series data)
* Source: [Helsinki Region Infoshare statistics API](http://dev.hel.fi/stats/)


List of potential data sources to be added to the package can be found [here](todo-datasets.Rmd).

## Installation

Release version for general users:


```r
install.packages("helsinki")
```

Development version for developers:


```r
install.packages("devtools")
library(devtools)
install_github("helsinki", "ropengov")
```

Load package.


```r
library(helsinki)
```

## <a name="aluejakokartat"></a>Helsinki region district maps

Helsinki region district maps (Helsingin seudun aluejakokartat) and election maps (äänestysalueet) from [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/) are available in the helsinki package with `data(aluejakokartat)`. The data are available as both spatial object (`sp`) and data frame (`df`). These are preprocessed in the [gisfin](https://github.com/rOpenGov/gisfin) package, and more examples can be found in the [gisfin tutorial](https://github.com/rOpenGov/gisfin/blob/master/vignettes/gisfin_tutorial.md). 


```r
# Load aluejakokartat and study contents
data(aluejakokartat)
str(aluejakokartat, m=2)
```

```
## List of 2
##  $ sp:List of 8
##   ..$ kunta            :Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots
##   ..$ pienalue         :Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots
##   ..$ pienalue_piste   :Formal class 'SpatialPointsDataFrame' [package "sp"] with 5 slots
##   ..$ suuralue         :Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots
##   ..$ suuralue_piste   :Formal class 'SpatialPointsDataFrame' [package "sp"] with 5 slots
##   ..$ tilastoalue      :Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots
##   ..$ tilastoalue_piste:Formal class 'SpatialPointsDataFrame' [package "sp"] with 5 slots
##   ..$ aanestysalue     :Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots
##  $ df:List of 8
##   ..$ kunta            :'data.frame':	1664 obs. of  7 variables:
##   ..$ pienalue         :'data.frame':	33594 obs. of  7 variables:
##   ..$ pienalue_piste   :'data.frame':	295 obs. of  3 variables:
##   ..$ suuralue         :'data.frame':	6873 obs. of  7 variables:
##   ..$ suuralue_piste   :'data.frame':	23 obs. of  3 variables:
##   ..$ tilastoalue      :'data.frame':	17279 obs. of  7 variables:
##   ..$ tilastoalue_piste:'data.frame':	125 obs. of  3 variables:
##   ..$ aanestysalue     :'data.frame':	35349 obs. of  11 variables:
```


## <a name="servicemap"></a>Service and event information

Function `get_servicemap()` retrieves regional service data from the new [Service Map API](http://api.hel.fi/servicemap/v1/), that contains data from the [Service Map](http://dev.hel.fi/servicemap/).


```r
# Search for "puisto" (park) (specify q="query")
search.puisto <- get_servicemap(query="search", q="puisto")
# Study results
str(search.puisto, m=1)
```

```
## List of 4
##  $ count   : num 1483
##  $ next    : chr "https://api.hel.fi/servicemap/v1/search/?page=2&q=puisto"
##  $ previous: NULL
##  $ results :List of 20
```

```r
# A lot of results found (count > 1000)
# Get names for the first 20 results
sapply(search.puisto$results, function(x) x$name$fi)
```

```
##  [1] "Perkkaan asukaspuisto"     "Leppävaaran asukaspuisto" 
##  [3] "Träskändan kartanopuisto"  "Niittykummunpuisto"       
##  [5] "Parkvillanpihan puisto"    "Trillapuisto"             
##  [7] "Albergan kartanopuisto"    "Koivuviidan kentän puisto"
##  [9] "Ruusutorpanpuisto"         "Ankkuripohjanpuisto"      
## [11] "Kuttulammenpuisto"         "Rinkelipuisto"            
## [13] "Sinisiimeksen puisto"      "Espoon keskuspuisto"      
## [15] "Kartanonpuisto"            "Kurkijoenpuisto"          
## [17] "Porttipuisto"              "Ryytimaan puisto"         
## [19] "Tikanpuisto"               "Lehtikaskenpuisto"
```

```r
# See what data is given for one service
names(search.puisto$results[[1]])
```

```
##  [1] "id"                        "connections"              
##  [3] "accessibility_properties"  "identifiers"              
##  [5] "data_source_url"           "name"                     
##  [7] "description"               "provider_type"            
##  [9] "street_address"            "address_zip"              
## [11] "phone"                     "email"                    
## [13] "www_url"                   "address_postal_full"      
## [15] "extensions"                "picture_url"              
## [17] "picture_caption"           "origin_last_modified_time"
## [19] "root_services"             "department"               
## [21] "organization"              "municipality"             
## [23] "services"                  "divisions"                
## [25] "keywords"                  "location"                 
## [27] "object_type"               "score"
```

```r
# More results could be retrieved by specifying 'page=2' etc.
```

Function `get_linkedevents()` retrieves regional event data from the new [Linked Events API](http://api.hel.fi/linkedevents/v0.1/).


```r
# Search for current events
events <- get_linkedevents(query="event")
# Get names for the first 20 results
sapply(events$data, function(x) x$name$fi)
```

```
##  [1] "Moniheli ry:n pop-up piste"                       
##  [2] "Enter ry opastaa"                                 
##  [3] "Virtuaalinen lukupiiri"                           
##  [4] "Moniheli ry:n pop-up piste"                       
##  [5] "Enter ry opastaa"                                 
##  [6] "Moniheli ry:n pop-up piste"                       
##  [7] "Virtuaalinen lukupiiri"                           
##  [8] "Moniheli ry:n pop-up piste"                       
##  [9] "Enter ry opastaa"                                 
## [10] "Millainen on sinun metsäsuhteesi?"                
## [11] "Virtuaalinen lukupiiri"                           
## [12] "Moniheli ry:n pop-up piste"                       
## [13] "Enter ry opastaa"                                 
## [14] "Helsinki Loves Developers: Luonnon monimuotoisuus"
## [15] "Moniheli ry:n pop-up piste"                       
## [16] "Virtuaalinen lukupiiri"                           
## [17] "Enter ry opastaa"                                 
## [18] "Vieraslajit Vantaan kasvimaailmassa"              
## [19] "Orkesteri tulee kirjastoosi"                      
## [20] "Kielikahvila arabiankielisille vanhemmille"
```

```r
# See what data is given for the first event
names(events$data[[1]])
```

```
##  [1] "id"                    "location"              "keywords"             
##  [4] "super_event"           "event_status"          "external_links"       
##  [7] "offers"                "data_source"           "publisher"            
## [10] "sub_events"            "videos"                "in_language"          
## [13] "audience"              "created_time"          "last_modified_time"   
## [16] "date_published"        "start_time"            "end_time"             
## [19] "custom_data"           "audience_min_age"      "audience_max_age"     
## [22] "super_event_type"      "deleted"               "replaced_by"          
## [25] "short_description"     "name"                  "location_extra_info"  
## [28] "provider"              "info_url"              "provider_contact_info"
## [31] "description"           "@id"                   "@context"             
## [34] "@type"                 "image"
```



## <a name="hri_stats"></a> Helsinki Region Infoshare statistics API

Function `get_hri_stats()` retrieves data from the [Helsinki Region Infoshare statistics API](http://dev.hel.fi/stats/).


```r
# Retrieve list of available data
stats.list <- get_hri_stats(query="")
# Show first results
head(stats.list)
```

```
##                                      NULL 
##             "L113_viheralue_kaupunginosa" 
##                                      NULL 
##                      "L32_yksikkopaastot" 
##                                      NULL 
##                   "J1_loppusijoitettavat" 
##                                      NULL 
##                    "I13_maailman_paastot" 
##                                      NULL 
##       "J13_sekajatteen_maara_kiinteistot" 
##  Helsingin väestö äidinkielen mukaan 1.1. 
## "aluesarjat_a03s_hki_vakiluku_aidinkieli"
```

Specify a dataset to retrieve. The output is currently a three-dimensional array.


```r
# Retrieve a specific dataset
stats.res <- get_hri_stats(query=stats.list[1])
# Show the structure of the results
str(stats.res)
```

```
##  num [1:6, 1:34] 11606 5607 2.07 0.65 0.15 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ muuttuja  : chr [1:6] "Asukkaita" "Asukastiheys (hlö/km2)" "Maapinta-ala (km2)" "Viheralueiden pinta-ala (km2)" ...
##   ..$ peruspiiri: chr [1:34] "Vironniemi" "Ullanlinna" "Kampinmalmi" "Taka-Töölö" ...
```

The implementation will be updated and more examples will be added in the near future.


### Citation

**Citing the data:** See `help()` to get citation information for each data source individually.

**Citing the R package:**


```r
citation("helsinki")
```

```

Kindly cite the helsinki R package as follows:

  (C) Juuso Parkkinen, Leo Lahti and Joona Lehtomaki 2014. helsinki R
  package

A BibTeX entry for LaTeX users is

  @Misc{,
    title = {helsinki R package},
    author = {Juuso Parkkinen and Joona Lehtomaki and Leo Lahti},
    year = {2014},
  }

Many thanks for all contributors! For more info, see:
https://github.com/rOpenGov/helsinki
```

### Session info


This vignette was created with


```r
sessionInfo()
```

```
## R version 4.0.0 (2020-04-24)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.1 LTS
## 
## Matrix products: default
## BLAS:   /home/lei/bin/R-4.0.0/lib/libRblas.so
## LAPACK: /home/lei/bin/R-4.0.0/lib/libRlapack.so
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] helsinki_0.9.30 RCurl_1.98-1.2  maptools_1.0-1  sp_1.4-2       
## [5] rmarkdown_2.3   knitr_1.29     
## 
## loaded via a namespace (and not attached):
##  [1] lattice_0.20-41 digest_0.6.25   bitops_1.0-6    grid_4.0.0     
##  [5] magrittr_1.5    evaluate_0.14   rlang_0.4.7     stringi_1.4.6  
##  [9] rjson_0.2.20    tools_4.0.0     stringr_1.4.0   foreign_0.8-80 
## [13] xfun_0.16       yaml_2.2.1      compiler_4.0.0  htmltools_0.5.0
```

