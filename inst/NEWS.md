helsinki 0.9.31 (2021-04-27)
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
        
  * Slightly updated vignettes to reflect on changes
  * Improved documentation for `get_servicemap()` and `get_linkedevents()`
        
        
helsinki 0.9.16 (2014-05-12)
=========================
          
  * Package updated a lot


helsinki 0.9.01 (2013-12-17)
=========================
  
  * Package separated from sorvi
