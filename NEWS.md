helsinki 1.0.6 (2022-11-30)
=========================

### UPCOMING CHANGES

 * In future versions of this package, functions such as `get_rakennustietoruudukko()`, `get_vaestotietoruudukko()`, `get_hri_stats()` and `get_city_map()` may be changed from their current implementation due to expected changes in their relevant APIs.

### MINOR IMPROVEMENTS

 * Added option to download data from years 1997-1998 and 2009-2014 to `get_rakennustietoruudukko()` and years 1997-2003 and 2008-2014 to `get_vaestotietoruudukko()` via HRI data repository.
 * Added new internal functions `get_hri_dataset_list()` and `get_hri_dataset_metadata()` to facilitate abovementioned new features and always return up-to-date download URLs for zipped datasets.
 * Functions relying on HTTP requests should now return informative messages instead of warnings and errors if an internet resource is not available. New internal function `gracefully_fail()` facilitates this.
 
### DEPRECATED AND DEFUNCT

 * Traces of deprecated *get_hsy()* function have now been removed from the package

helsinki 1.0.5 (2021-09-27)
=========================

### DEPRECATED AND DEFUNCT

 * Dataset `aluejakokartat` now removed from package. As a replacement it is recommended to use `get_city_map()` function to download up-to-date maps of different cities.

helsinki 1.0.3 (2021-08-30)
=========================

### MINOR IMPROVEMENTS

 * wfs_api made to output messages instead of warnings and errors in case of connectivity and other problems
 * `get_rakennustietoruudukko()` and `get_vaestotietoruudukko()` now have 2020 data, one exceptionally named dataset from 2016 now downloads correctly
 * Vignette examples now more robust against unexpected errors

helsinki 1.0.1 (2021-05-09)
=========================
  
### NEW FEATURES
  
 * New function `get_feature_list()` added to easily list all available features in a WFS API
 * New function `select_feature()` added to interactively browse and select features from WFS API 
 * New function `get_feature()` added for a simplified experience when interacting with wfs_api()
 * New function `get_city_map()` added to interactively download city administrative boundaries from an API instead of having to provide them with the package
 * New functions `wfs_api()` and `to_sf()` added from another rOpenGov-package, fmi2, to interact with WFS APIs
    
### MINOR IMPROVEMENTS
    
 * Improved output for `get_servicemap()` and `get_linkedevents()`
 * Rmarkdown added as an explicit dependency, as required by knitr-package maintainers
 * Using period.separated naming for function parameters and underscore_separated naming for function names and objects inside functions, as distinction between the two is sometimes useful for increased code legibility
        
### DEPRECATED AND DEFUNCT
        
 * `get_hsy()` now deprecated due to URL changes. Use `get_vaestotietoruudukko()` and `get_rakennustietoruudukko` instead.
 * Older datasets must now be downloaded directly from Helsinki Region Infoshare website (for example https://hri.fi/data/en_GB/dataset/rakennustietoruudukko in the case of Building Information Grid) whereas package functionalities revolve around interacting with and downloading data from WFS API.
 * Package no longer has `maptools` and `RCurl` as dependencies and no longer imports `rjson`, uses `httr`, `httpcache` and `jsonlite` instead
        
### DOCUMENTATION FIXES
        
 * Updated vignette
 * Improved documentation for `get_servicemap()` and `get_linkedevents()`
        
        
helsinki 0.9.29 (2017-02-18)
=========================

 * Package released in CRAN
        
        
helsinki 0.9.16 (2014-05-12)
=========================
          
 * Package updated a lot


helsinki 0.9.01 (2013-12-17)
=========================
  
 * Package separated from sorvi

