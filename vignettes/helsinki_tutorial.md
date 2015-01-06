<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->




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
* Source: [Helsingin seudun ympäristöpalvelut, HSY](http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx)

[Service and event information](#servicemap)

* [Helsinki region Service Map API](http://api.hel.fi/servicemap/v1/) (Pääkaupunkiseudun Palvelukartta)
* [Helsinki Linked Event API](http://api.hel.fi/linkedevents/v0.1/)

[Helsinki Region Infoshare statistics API](#hri_stats)

* [Aluesarjat (original source)](http://www.aluesarjat.fi/) (regional time series data)
* Source: [Helsinki Region Infoshare statistics API](http://dev.hel.fi/stats/)


List of potential data sources to be added to the package can be found [here](https://github.com/rOpenGov/helsinki/blob/master/vignettes/todo-datasets.md).

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


## <a name="hsy"></a> Helsinki region environmental services

Retrieve data from [Helsingin seudun ympäristöpalvelut (HSY)](http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx) with `get_hsy()`.

### Population grid 

Population grid (väestötietoruudukko) with 250m x 250m grid size in year 2013 contains the number of people in different age groups. The most rarely populated grids are left out (0-4 persons), and grids with less than 99 persons are censored with '99' to guarantee privacy.


```r
sp.vaesto <- get_hsy(which.data="Vaestotietoruudukko", which.year=2013)
```

```
## IMPORTANT NOTE! HSY open data services have been recently updated and get_hsy() function is outdated! It will be updated soon, meanwhile use the services directly at https://www.hsy.fi/fi/asiantuntijalle/avoindata/Sivut/default.aspx.
```

```r
head(sp.vaesto@data)
```

```
## Error in head(sp.vaesto@data): trying to get slot "data" from an object of a basic class ("NULL") with no slots
```


### Helsinki building information

Building information grid (rakennustietoruudukko) in Helsinki region on grid-level (500m x 500m): building counts (lukumäärä), built area (kerrosala), usage (käyttötarkoitus), and region
efficiency (aluetehokkuus).


```r
sp.rakennus <- get_hsy(which.data="Rakennustietoruudukko", which.year=2013)  
```

```
## IMPORTANT NOTE! HSY open data services have been recently updated and get_hsy() function is outdated! It will be updated soon, meanwhile use the services directly at https://www.hsy.fi/fi/asiantuntijalle/avoindata/Sivut/default.aspx.
```

```r
head(sp.rakennus@data)
```

```
## Error in head(sp.rakennus@data): trying to get slot "data" from an object of a basic class ("NULL") with no slots
```

### Helsinki building area capacity

Building area capacity per municipal region (kaupunginosittain summattua tietoa rakennusmaavarannosta). Plot with number of buildlings with `spplot()`.


```r
sp.ramava <- get_hsy(which.data="SeutuRAMAVA_tila", which.year=2013)  
```

```
## IMPORTANT NOTE! HSY open data services have been recently updated and get_hsy() function is outdated! It will be updated soon, meanwhile use the services directly at https://www.hsy.fi/fi/asiantuntijalle/avoindata/Sivut/default.aspx.
```

```r
head(sp.ramava@data)
```

```
## Error in head(sp.ramava@data): trying to get slot "data" from an object of a basic class ("NULL") with no slots
```

```r
# Values with less than five units are given as 999999999, set those to zero
sp.ramava@data[sp.ramava@data==999999999] <- 0
```

```
## Error in sp.ramava@data[sp.ramava@data == 999999999] <- 0: trying to get slot "data" from an object of a basic class ("NULL") with no slots
```

```r
# Plot number of buildings for each region
spplot(sp.ramava, zcol="RAKLKM", main="Number of buildings in each 'tilastoalue'", col.regions=colorRampPalette(c('blue', 'gray80', 'red'))(100))
```

```
## Error in (function (classes, fdef, mtable) : unable to find an inherited method for function 'spplot' for signature '"NULL"'
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
##  $ count   : num 1662
##  $ next    : chr "http://api.hel.fi/servicemap/v1/search/?q=puisto&page=2"
##  $ previous: NULL
##  $ results :List of 20
```

```r
# A lot of results found (count > 1000)
# Get names for the first 20 results
sapply(search.puisto$results, function(x) x$name$fi)
```

```
##  [1] "Mankkaan asukaspuisto"              
##  [2] "Tapiolan asukaspuisto"              
##  [3] "Olarin asukaspuisto"                
##  [4] "Perkkaan asukaspuisto"              
##  [5] "Hurtigin puisto"                    
##  [6] "Kaupungintalon puisto"              
##  [7] "Matinkylän asukaspuisto"            
##  [8] "Kylätalo Palttinan asukaspuisto"    
##  [9] "Leppävaaran asukaspuisto"           
## [10] "Viherkallion asukaspuisto"          
## [11] "Karakallion asukaspuisto"           
## [12] "Suvelan asukaspuisto"               
## [13] "Asematien puisto"                   
## [14] "Kasavuoren puisto"                  
## [15] "Stenbergin puisto"                  
## [16] "Nurmilinnunpuisto"                  
## [17] "Itärannan puisto/ Otsonlahdenpuisto"
## [18] "Lehtikaskenpuisto"                  
## [19] "Alberganesplanadin puisto"          
## [20] "Kotitontunpuisto"
```

```r
# See what data is given for one service
names(search.puisto$results[[1]])
```

```
##  [1] "connections"               "accessibility_properties" 
##  [3] "id"                        "data_source_url"          
##  [5] "name"                      "description"              
##  [7] "provider_type"             "department"               
##  [9] "organization"              "street_address"           
## [11] "address_zip"               "phone"                    
## [13] "email"                     "www_url"                  
## [15] "address_postal_full"       "municipality"             
## [17] "picture_url"               "picture_caption"          
## [19] "origin_last_modified_time" "root_services"            
## [21] "services"                  "divisions"                
## [23] "keywords"                  "location"                 
## [25] "object_type"               "score"
```

```r
# More results could be retrieved by specifying 'page=2' etc.
```

Function `get_linkedevents()` retrieves regional event data from the new [Linked Events API](http://api.hel.fi/linkedevents/v0.1/).


```r
# Searh for current events
events <- get_linkedevents(query="event")
# Get names for the first 20 results
sapply(events$data, function(x) x$name$fi)
```

```
##  [1] "Ladykillers - Sarjahurmaajat"      
##  [2] "Ladykillers - Sarjahurmaajat"      
##  [3] "Ladykillers - Sarjahurmaajat"      
##  [4] "Melontaa Pitkäjärvellä"            
##  [5] "Ladykillers - Sarjahurmaajat"      
##  [6] "Ladykillers - Sarjahurmaajat"      
##  [7] "Lumikuningatar"                    
##  [8] "Kuningas kuolee"                   
##  [9] "Helsingin Urkukesä, päivämusiikkia"
## [10] "Helsingin Urkukesä, päivämusiikkia"
## [11] "Helsingin Urkukesä, päivämusiikkia"
## [12] "Helsingin Urkukesä, päivämusiikkia"
## [13] "Helsingin Urkukesä, päivämusiikkia"
## [14] "Helsingin Urkukesä, päivämusiikkia"
## [15] "Helsingin Urkukesä, päivämusiikkia"
## [16] "Helsingin Urkukesä, päivämusiikkia"
## [17] "Helsingin Urkukesä, päivämusiikkia"
## [18] "Helsingin Urkukesä, päivämusiikkia"
## [19] "Jukka Puotila Show"                
## [20] "Kuningas kuolee"
```

```r
# See what data is given for the first event
names(events$data[[1]])
```

```
##  [1] "location"            "keywords"            "super_event"        
##  [4] "event_status"        "external_links"      "offers"             
##  [7] "sub_events"          "id"                  "custom_data"        
## [10] "data_source"         "image"               "origin_id"          
## [13] "created_time"        "last_modified_time"  "last_modified_by"   
## [16] "date_published"      "publisher"           "start_time"         
## [19] "end_time"            "audience"            "short_description"  
## [22] "name"                "headline"            "location_extra_info"
## [25] "description"         "secondary_headline"  "info_url"           
## [28] "provider"            "@id"                 "@type"
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
##                                         Helsingin väestö äidinkielen mukaan 1.1. 
##                                        "aluesarjat_a03s_hki_vakiluku_aidinkieli" 
## Työpaikat Helsingissä (alueella työssäkäyvät) toimialan (TOL 1988) mukaan 31.12. 
##                                            "aluesarjat_a07s_hki_tyopaikat_tol88" 
##               Vantaalla asuva työllinen työvoima sukupuolen ja iän mukaan 31.12. 
##                                         "aluesarjat_c01s_van_tyovoima_sukupuoli" 
##             Espoon lapsiperheet lasten määrän mukaan (0-17-vuotiaat lapset) 1.1. 
##                                        "aluesarjat_b03s_esp_lapsiperheet_alle18" 
##                                             Väestö iän ja sukupuolen mukaan 1.1. 
##                                      "aluesarjat_hginseutu_va_vr01_vakiluku_ika" 
##                     Helsingin asuntotuotanto rahoitusmuodon ja huoneluvun mukaan 
##                                     "aluesarjat_a03hki_astuot_rahoitus_huonelkm"
```

Specify a dataset to retrieve. The output is currently a three-dimensional array.


```r
# Retrieve a specific dataset
stats.res <- get_hri_stats(query=stats.list[1])
# Show the structure of the results
str(stats.res)
```

```
##  num [1:23, 1:4, 1:197] 497526 501518 508659 515765 525031 ...
##  - attr(*, "dimnames")=List of 3
##   ..$ vuosi     : chr [1:23] "1992" "1993" "1994" "1995" ...
##   ..$ aidinkieli: chr [1:4] "Kaikki äidinkielet" "Suomi ja saame" "Ruotsi" "Muu kieli"
##   ..$ alue      : chr [1:197] "091 Helsinki" "091 1 Eteläinen suurpiiri" "091 101 Vironniemen peruspiiri" "091 10 Kruununhaka" ...
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

  (C) Juuso Parkkinen, Leo Lahti and Joona Lehtomaki 2014.
  helsinki R package

A BibTeX entry for LaTeX users is

  @Misc{,
    title = {helsinki R package},
    author = {Juuso Parkkinen and Leo Lahti and Joona Lehtomaki},
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
## R version 3.1.2 (2014-10-31)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] knitr_1.8       helsinki_0.9.24 RCurl_1.95-4.3  bitops_1.0-6   
## [5] maptools_0.8-30 sp_1.0-15      
## 
## loaded via a namespace (and not attached):
## [1] evaluate_0.5.5  foreign_0.8-61  formatR_1.0     grid_3.1.2     
## [5] lattice_0.20-29 markdown_0.7.4  rjson_0.2.14    stringr_0.6.2  
## [9] tools_3.1.2
```

