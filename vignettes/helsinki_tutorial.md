<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->


```r
opts_knit$set(upload.fun = imgur_upload, base.url = NULL)  # upload all images to imgur.com
# opts_chunk$set(fig.width=5, fig.height=5, cache=TRUE)
```


Helsinki  R tools
===========

This is an [rOpenGov](https://github.com/rOpenGov/helsinki) R package
providing tools for open data in the Helsinki region in Finland.

## Available data

The following data sets are currently available:
* [Helsinki region environmental services](#helsinki-region-environmental-services)
* [Helsinki Real Estate Department](#helsinki-real-estate-department)
* [Helsinki Service Map](#helsinki-service-map)


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


Further installation and development instructions at the [Github
page](https://github.com/rOpenGov/helsinki).

## Helsinki region environmental services

Data from Helsingin seudun ympäristöpalvelut, HSY.

### Population grid

Download population information from [HSY database](http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx) (C) 2013 HSY, and inspect the data manually. Some rarely populated grids are censored with '99' to guarantee privacy.


```r
sp <- get_HSY_data("Vaestotietoruudukko")
df <- as.data.frame(sp)
head(df)
```

```
##   INDEX ASUKKAITA ASVALJYYS IKA0_9 IKA10_19 IKA20_29 IKA30_39 IKA40_49
## 0   688         5        50     99       99       99       99       99
## 1   703         6        42     99       99       99       99       99
## 2   710         7        36     99       99       99       99       99
## 3   711         7        64     99       99       99       99       99
## 4   715        16        28     99       99       99       99       99
## 5   864        10        65     99       99       99       99       99
##   IKA50_59 IKA60_69 IKA70_79 IKA_YLI80
## 0       99       99       99        99
## 1       99       99       99        99
## 2       99       99       99        99
## 3       99       99       99        99
## 4       99       99       99        99
## 5       99       99       99        99
```



### Helsinki building information

Information of buildings in Helsinki region. Data obtained from (C)
HSY 2013. Grid-level (500mx500m) information on building counts
(lukumaara), built area (kerrosala), usage (kayttotarkoitus), region
efficiency (aluetehokkuus).


```r
sp <- get_HSY_data("Rakennustietoruudukko", 2013)
df <- as.data.frame(sp)
head(df)
```

```
##   INDEX RAKLKM RAKLKM_AS RAKLKM_MUU KERALA_YHT KERALA_AS KERALA_MUU
## 0   688      3         2          1        324       282         42
## 1   691      3         2          1         90        80         10
## 2   692      9         4          5        286       206         80
## 3   702      2         2          0        262       262          0
## 4   703      3         2          1        373       326         47
## 5   710      6         2          4        370       302         68
##   KATAKER1  KATAKER2  KATAKER3 SUMMA1    SUMMA2    SUMMA3 ALUETEHOK
## 0       11       941 999999999    282        42 999999999  0.005288
## 1       41       941 999999999     80        10 999999999  0.001440
## 2       41       941       931    206        47        33  0.007304
## 3       11 999999999 999999999    262 999999999 999999999  0.004192
## 4       11       941 999999999    326        47 999999999  0.005968
## 5       11       931       941    302        39        29  0.005920
##   KATAKER1.description    KATAKER2.description    KATAKER3.description
## 0  Yhden asunnon talot       Talousrakennukset Puuttuvan tiedon merkki
## 1   Vapaa-ajan asunnot       Talousrakennukset Puuttuvan tiedon merkki
## 2   Vapaa-ajan asunnot       Talousrakennukset        Saunarakennukset
## 3  Yhden asunnon talot Puuttuvan tiedon merkki Puuttuvan tiedon merkki
## 4  Yhden asunnon talot       Talousrakennukset Puuttuvan tiedon merkki
## 5  Yhden asunnon talot        Saunarakennukset       Talousrakennukset
```


### Helsinki building area capacity

Building area capacity per municipal region (kaupunginosittain summattu tieto rakennusmaavarannosta). Data obtained from (C) HSY 2013. 


```r
sp <- get_HSY_data("SeutuRAMAVA_kosa")
df <- as.data.frame(sp)
head(df)
```

```
##   KUNTA KAUPOSANRO         NIMI  NIMI_SE    RAKLKM    YKSLKM RAKEOIKEUS
## 0   091        042    KULOSAARI   BRÄNDÖ       463       316     299000
## 1   091        038        MALMI     MALM      1854      1124    2117691
## 2   091        006         EIRA     EIRA        99        92      79754
## 3   091        023      TOUKOLA  MAJSTAD       360       215     659170
## 4   091        024      KUMPULA  GUMTÄKT       354       184     384043
## 5   091        005 SALMENKALLIO SUNDBERG 999999999 999999999          0
##   KARA_YHT KARA_AS KARA_MUU RAKERA_YHT RAKERA_AS RAKERA_MUU VARA_YHT
## 0   288232  225049    63183       8343       961       7382    21555
## 1  1736853 1078574   658279      26176      7211      18965   400414
## 2    93880   83956     9924          0         0          0      294
## 3   607988  357174   250814      41364     41210        154    78023
## 4   324227  151115   173112         36         0         36    66874
## 5        0       0        0          0         0          0        0
##   VARA_AS VARA_AP VARA_AK VARA_MUU VANHINRAKE UUSINRAKE  OMLAJI_1
## 0   16599   14897    1702     4956       1890      2013        11
## 1   89321   51455   37866   311093       1890      2013         2
## 2     294       0     294        0       1901      2000        11
## 3   10514     140   10374    67509       1874      2013         2
## 4    4214     170    4044    62660       1919      2013         2
## 5       0       0       0        0  999999999 999999999 999999999
##                                 OMLAJI_1S  OMLAJI_2
## 0 Asunto-osakeyhtiö tai asunto-osuuskunta        11
## 1                                Helsinki         2
## 2 Asunto-osakeyhtiö tai asunto-osuuskunta        11
## 3                                Helsinki         2
## 4                                Helsinki         2
## 5                                    <NA> 999999999
##                                 OMLAJI_2S  OMLAJI_3
## 0 Asunto-osakeyhtiö tai asunto-osuuskunta        11
## 1                                Helsinki         2
## 2 Asunto-osakeyhtiö tai asunto-osuuskunta        11
## 3                                Helsinki         2
## 4                                Helsinki         2
## 5                                    <NA> 999999999
##                                 OMLAJI_3S
## 0 Asunto-osakeyhtiö tai asunto-osuuskunta
## 1                                Helsinki
## 2 Asunto-osakeyhtiö tai asunto-osuuskunta
## 3                                Helsinki
## 4                                Helsinki
## 5                                    <NA>
```



### Further HSY data

[HSY website](http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx) has more data that will be included in the helsinki package later.


## Helsinki Real Estate Department

Data from Helsingin kaupungin kiinteistövirasto, HKK.

Retrieve [HKK](http://kartta.hel.fi/avoindata/index.html) data sets.

### Helsinki address information


```r
dat <- get_HKK_address_data("Helsingin osoiteluettelo")
head(dat)
```

```
##           katunimi osoitenumero osoitenumero2 osoitekirjain       N
## 1         Haapatie           24            NA             b 6682555
## 2        Pallokuja           12            NA               6678084
## 3       Poutunkuja            4            NA               6678926
## 4       Haukkakuja            1            NA               6683284
## 5       Haukkakuja            4            NA               6683307
## 6 Merikapteenintie            4            NA               6681909
##          E kaupunki           gatan      staden tyyppi tyyppi_selite
## 1 25499401 Helsinki        Aspvägen Helsingfors      1  osoite, katu
## 2 25508664 Helsinki     Bollgränden Helsingfors      1  osoite, katu
## 3 25494428 Helsinki   Pouttugränden Helsingfors      1  osoite, katu
## 4 25503858 Helsinki     Falkgränden Helsingfors      1  osoite, katu
## 5 25503852 Helsinki     Falkgränden Helsingfors      1  osoite, katu
## 6 25512316 Helsinki Sjökaptensvägen Helsingfors      1  osoite, katu
```



```r
dat <- get_HKK_address_data("Seudullinen osoiteluettelo")
head(dat)
```

```
##          katunimi osoitenumero osoitenumero2 osoitekirjain       N
## 1    Gråängsvägen            0            NA               6673565
## 2        Grådalen            0            NA               6673640
## 3      Lillaisarn            0            NA               6665767
## 4 Herrö Träskholm            0            NA               6663250
## 5      Stora Bodö            0            NA               6666765
## 6      Torraisarn            0            NA               6664992
##          E kaupunki            gatan staden tyyppi   tyyppi_selite
## 1 25478911    Espoo  Harmaaniityntie   Esbo      1 osoite tai katu
## 2 25478711    Espoo     Harmaalaakso   Esbo      1 osoite tai katu
## 3 25483084    Espoo       Lillaisarn   Esbo      1 osoite tai katu
## 4 25481439    Espoo Herrön Träskholm   Esbo      1 osoite tai katu
## 5 25485583    Espoo       Stora Bodö   Esbo      1 osoite tai katu
## 6 25482421    Espoo       Torraisarn   Esbo      1 osoite tai katu
```


## Helsinki Service Map

Retrieve data from [Helsinki Service Map](http://www.hel.fi/palvelukartta/?lang=en) [API](http://www.hel.fi/palvelukarttaws/rest/ver2_en.html).


```r
# Get servicetree
pk.servicetree <- get_ServiceMap_data("servicetree")
# Get id for parks
str(pk.servicetree[[1]]$children[[7]]$children[[2]])
```

```
## List of 5
##  $ id      : num 25664
##  $ name_fi : chr "Viheralueet"
##  $ name_sv : chr "Grönområden"
##  $ name_en : chr "Green areas"
##  $ children: list()
```

```r
# Get parks data
parks.data <- get_ServiceMap_data("unit", service = 25664)
# Check what data is given for the first park
str(parks.data[[1]])
```

```
## List of 14
##  $ id                : num 26553
##  $ org_id            : num 92
##  $ provider_type     : num 101
##  $ name_fi           : chr "Puisto, lähivirkistysalue tai vastaava"
##  $ name_sv           : chr "Puisto, lähivirkistysalue tai vastaava"
##  $ name_en           : chr "Puisto, lähivirkistysalue tai vastaava"
##  $ latitude          : num 60.4
##  $ longitude         : num 25.1
##  $ northing_etrs_gk25: num 6693492
##  $ easting_etrs_gk25 : num 25503793
##  $ address_city_fi   : chr "Vantaa"
##  $ address_city_sv   : chr "Vantaa"
##  $ address_city_en   : chr "Vantaa"
##  $ phone             : chr "09 8392 2407"
```



### Licensing and Citations

This work can be freely used, modified and distributed under the
[Two-clause FreeBSD
license](http://en.wikipedia.org/wiki/BSD\_licenses). Cite Helsinki R
package and and the appropriate data provider, including a url
link. Kindly cite the R package as 'Leo Lahti, Juuso Parkkinen ja
Joona Lehtomäki (2013-2014). helsinki R package. URL:
https://github.com/rOpenGov/helsinki/'.

### Session info


This vignette was created with


```r
sessionInfo()
```

```
## R version 3.0.3 (2014-03-06)
## Platform: x86_64-apple-darwin10.8.0 (64-bit)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] knitr_1.5       helsinki_0.9.13 maptools_0.8-29 sp_1.0-14      
## [5] RCurl_1.95-4.1  bitops_1.0-6    rjson_0.2.13    roxygen2_3.1.0 
## 
## loaded via a namespace (and not attached):
##  [1] brew_1.0-6      codetools_0.2-8 digest_0.6.4    evaluate_0.5.1 
##  [5] foreign_0.8-60  formatR_0.10    grid_3.0.3      lattice_0.20-27
##  [9] Rcpp_0.11.1     stringr_0.6.2   tools_3.0.3
```


