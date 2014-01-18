## API

### GetHKK()

Retrieve HKK data 

This script retrieves data from Helsinki Real Estate Department (Helsingin kaupunki kiinteistovirasto HKK) through the HKK website http://kartta.hel.fi/avoindata/index.html

Functionality should follow `GetHSY`

@param `which.data` a string with one of the values `"Aluejakorajat"`, `"Aanesysaluejako"` or `"Seutukartta"`  

@return **Undecided**: either (1) a Shape object or (2) a list of Shape objects (from `SpatialPolygonsDataFrame` class)

NOTE: in sorvi 0.1.44 data set Aluejakorajat is available through `GetHRIaluejakokartat`. This functionality could be merged to `GetHKK` in the future.

## Work stages

1. Download the requested data set from HKK-webpages
2. Unzip the data set into a predefined location [SORVI_PKG_LOCATION]/extdata (should the location be included in the function call?)
At this point the pre-processing of the datasets diverge  

`Aanestysaluejako`

Data set includes the elections districts for the cities of the capital region (Helsinki, Espoo, Kauniainen and Vantaa) in MapInfo-format (OGR will handle these just fine). CRS is Finland KKJ2 (EPSG: 2392). All feature datasets have different schemas with varying amount of information. Additionally there is an Excel file (Aanestyaluekoodit.xls) with information for all cities, such as voting district names and codes.

1. Extract the information for each city from Excel-sheets into data frames (`read.xls`)
2. Pre-process the fields in the voting information (break down fields, handle encoding etc.)
3. Read in the spatial data for each city (`readOGR`)
4. Merge data from the voting information tables and the spatial data
5. Either  
  * return a list of `SpatialPolygonDataframes`  
  * Merge all cities into 1 sp-object. This could be done e.g. using `spRbind`. Note that biding the sp-objects would call for defining unique FIDs for all the polygons using `spChFIDs` on the voting district code

