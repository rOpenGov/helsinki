
# The combination of some data and an aching desire for an answer does not
# ensure that a reasonable answer can be extracted from a given body of
# data. ~ John Tukey

#' Retrieve HSY data 
#'
#' Retrieves data from Helsinki Region Environmental
#' Services Authority (Helsingin seudun ymparistopalvelu HSY) 
#' http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx
#' For data description (in Finnish) see:
#' http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf. 
#' The data copyright (C) HSY 2011.
#'
#' Arguments:
#' @param which.data A string. Specify the name of the retrieved HSY data set. Options: Vaestotietoruudukko; Rakennustietoruudukko; SeutuRAMAVA_kosa; SeutuRAMAVA_tila. These are documented in HSY data description document (see above).
#' @param which.year An integer. Specify the year for the data to be retrieved.
#' @param data.dir A string. Specify a temporary folder for storing downloaded data.
#'
#' @return Shape object (from SpatialPolygonsDataFrame class)
#' @export
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @importFrom maptools readShapePoly
#' @references See citation("helsinki") 
#' @author Juuso Parkkinen and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # sp <- get_HSY_data("Vaestoruudukko")
#' @keywords utilities

get_HSY_data <- function (which.data=NULL, which.year=2013, data.dir=tempdir()) {
    
  if (is.null(which.data)) {
    message("Available HSY datasets:
  'Vaestotietoruudukko': Ruutukohtaista tietoa vaeston lukumaarasta, ikajakaumasta ja asumisvaljyydesta. Vuodet: 1997-2003, 2008-2013.
  'Rakennustietoruudukko': Ruutukohtaista tietoa rakennusten lukumaarasta, kerrosalasta, kayttotarkoituksesta ja aluetehokkuudesta. Ruutukoko 500x500 metria. Vuodet: 1997-2003, 2008-2013.
  'SeutuRAMAVA_kosa': kaupunginosittain summattua tietoa rakennusmaavarannosta. Vuodet: 2010-2013.
  'SeutuRAMAVA_tila': tilastoalueittain summattua tietoa rakennusmaavarannosta. Vuodet: 1997-2001, 2010-2013")
    stop("Please specify 'which.data'")
  }
  
  if (which.data=="SeutuRAMAVA_tila" & which.year==2012)
    stop("Data for SeutuRAMAVA_tila 2012 is not readable with maptools::readShapePoly. You can try using the rgdal-package if you need to access that data!")
  
  # Create data.dir if it does not exist
  if (!file.exists(data.dir))
    dir.create(data.dir)
  
  
  ## Download data ----------------------------------------------------
  
  # Specify download url
  if (which.data=="Vaestotietoruudukko") {
    if (which.year==2013)
      zip.file <- paste0("Vaestotietoruudukko", "_", which.year, "_SHP.zip")
    else if (which.year==2012)
      zip.file <- paste0("Vaestoruudukko", "_", which.year, ".zip")
    else
      zip.file <- paste0("Vaestoruudukko", "_SHP_", which.year, ".zip")
    
  } else if (which.data=="Rakennustietoruudukko") {
    if (which.year==2013)
      zip.file <- paste0("Rakennustietoruudukko", "_", which.year, "_SHP.zip")
    else if (which.year==2012)
      zip.file <- paste0("Rakennustietoruudukko", "_", which.year, ".zip")
    else
      zip.file <- paste0("Rakennustietoruudukko", "_SHP_", which.year, ".zip")
    
  } else if (which.data=="SeutuRAMAVA_kosa") {
    if (which.year==2013) {
      zip.file <- paste0("SeutuRamava_kosa_", which.year, "_SHP.zip")
    } else if (which.year %in% c(2011, 2012)) {
      zip.file <- paste0("SeutuRAMAVA_SHP_", which.year, ".zip")
    } else {
      zip.file <- paste0("SeutuRAMAVA_SHP.zip")
    }
    
  } else if (which.data=="SeutuRAMAVA_tila") {
    if (which.year==2013) {
      zip.file <- paste0("SeutuRamava_tila_", which.year, "_SHP.zip")
    } else if (which.year==2012) {
      zip.file <- paste0("SeutuRAMAVA_tila_shp", which.year, ".zip")
    } else {
      zip.file <- paste0("SeutuRAMAVA_tila_", which.year, "_SHP.zip")
    }
  } else {
    stop("Invalid 'which.data' argument")
  }

  # Download data
  if (which.data=="SeutuRAMAVA_kosa" & which.year==2010) {
    remote.zip <- paste0("http://www.hsy.fi/seututieto/Documents/Paikkatiedot/", zip.file) 
  } else {
    remote.zip <- paste0("http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Documents/", zip.file)
  }
  local.zip <- file.path(data.dir, zip.file)
  message("Dowloading ", remote.zip, "\ninto ", local.zip, "\n")
  download.file(remote.zip, destfile = local.zip)
  
  
  ## Process data -----------------------------------------------
  
  # Unzip the downloaded zip file
  unzip(local.zip, exdir = data.dir)
  
  # Define shapefile
  if (which.data=="Vaestotietoruudukko") {
    message("For detailed description of ", which.data, " see\nhttp://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Documents/Vaestoruudukko.pdf")
    if (which.year %in% c(2012, 2013))
      sp.file <- paste0(data.dir, "/Vaestotietoruudukko_", which.year, ".shp")
    else
      sp.file <- paste0(data.dir, "/Vaestoruudukko_", which.year, ".shp")
    
  } else if (which.data=="Rakennustietoruudukko") {
    message("For detailed description of ", which.data, " see\nhttp://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Documents/Rakennustietoruudukko.pdf")
    if (which.year==2012)
      sp.file <- paste0(data.dir, "/Rakennustitetoruudukko_", which.year, ".shp")
    else
      sp.file <- paste0(data.dir, "/Rakennustietoruudukko_", which.year, ".shp")
    
  } else if (which.data=="SeutuRAMAVA_kosa") {
    message("For detailed description of ", which.data, " see\nhttp://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Documents/SeutuRAMAVA.pdf")
    if (which.year==2013)
      sp.file <- paste0(data.dir, "/SeutuRamava_kosa_", which.year, ".shp")
    else if (which.year==2012)
      sp.file <- paste0(data.dir, "/SeutuRAMAVA_kosa_", which.year, ".shp")
    else
      sp.file <- paste0(data.dir, "/SeutuRAMAVA_", which.year, ".shp")
    
  } else if (which.data=="SeutuRAMAVA_tila") {
    message("For detailed description of ", which.data, " see\nhttp://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Documents/SeutuRAMAVA.pdf")
    if (which.year==2013)
      sp.file <- paste0(data.dir, "/SeutuRamava_tila_", which.year, ".shp")
    else if (which.year==2012)
      sp.file <- paste0(data.dir, "/SeutuRAMAVA_Tila_", which.year, ".shp")
    else
      sp.file <- paste0(data.dir, "/SeutuRAMAVA_", which.year, "_SHP.shp")
  }

  # Read shapefile
  sp <- maptools::readShapePoly(sp.file)
  
  # Add KATAKER to rakennustieto, mailaa '11' SePe:lle
  if (which.data=="Rakennustietoruudukko") {
    KATAKER.key <- kataker.key()
    kk.df <- data.frame(list(KATAKER = as.integer(names(KATAKER.key)), description = KATAKER.key))
    temp <- sp@data
    temp$KATAKER1.description <- kk.df$description[match(temp$KATAKER1, kk.df$KATAKER)]
    temp$KATAKER2.description <- kk.df$description[match(temp$KATAKER2, kk.df$KATAKER)]
    temp$KATAKER3.description <- kk.df$description[match(temp$KATAKER3, kk.df$KATAKER)]
    sp@data <- temp
    message("\nAdded KATAKER descriptions to Rakennustietoruudukko")
  }

  message("\nData loaded succesfully!")
  message("TODO: Fix proj4string")
  message("TODO: Fix characters")
  return(sp)
}


kataker.key <- function () {
  KATAKER.key <- c(
    "11"   = "Yhden asunnon talot", 
    "12"  = "Kahden asunnon talot", 
    "13"  = "Muut erilliset pientalot", 
    "21"  = "Rivitalot", 
    "22"  = "Ketjutalot", 
    "32"  = "Luhtitalot", 
    "39"  = "Muut kerrostalot", 
    "41"  = "Vapaa-ajan asunnot",
    "111" = "Myymalahallit", 
    "112" = "Liike- ja tavaratalot, kauppakeskukset",
    "119" = "Myymalarakennukset ", 
    "121" = "Hotellit, motellit, matkustajakodit, kylpylahotellit", 
    "123" = "Loma- lepo- ja virkistyskodit", 
    "124" = "Vuokrattavat lomamokit ja osakkeet (liiketoiminnallisesti)", 
    "129" = "Muut majoitusliikerakennukset",
    "131" = "Asuntolat, vanhusten palvelutalot, asuntolahotellit",
    "139" = "Muut majoitusrakennukset", 
    "141" = "Ravintolat, ruokalat ja baarit", 
    "151" = "Toimistorakennukset", 
    "161" = "Rautatie- ja linja- autoasemat, lento- ja satamaterminaalit", 
    "162" = "Kulkuneuvojen suoja- ja huoltorakennukset", 
    "163" = "Pysakointitalot", 
    "164" = "Tietoliikenteen rakennukset", 
    "165" = "Muut liikenteen rakennukset", 
    "169" = "Muut liikenteen rakennukset", 
    "211" = "Keskussairaalat", 
    "213" = "Muut sairaalat", 
    "214" = "Terveyskeskukset", 
    "215" = "Terveydenhoidon erityislaitokset (mm. kuntoutuslaitokset)", 
    "219" = "Muut terveydenhoitorakennukset", 
    "221" = "Vanhainkodit", 
    "222" = "Lastenkodit, koulukodit", 
    "223" = "Kehitysvammaisten hoitolaitokset", 
    "229" = "Muut huoltolaitosrakennukset", 
    "231" = "Lasten paivakodit", 
    "239" = "Muut sosiaalitoimen rakennukset", 
    "241" = "Vankilat", 
    "311" = "Teatterit, konsertti- ja kongressitalot, oopperat", 
    "312" = "Elokuvateatterit",
    "322" = "Kirjastot", 
    "323" = "Museot, taidegalleriat",
    "324" = "Nayttelyhallit", 
    "331" = "Seurain-, nuoriso- yms. talot",
    "341" = "Kirkot, kappelit, luostarit, rukoushuoneet",
    "342" = "Seurakuntatalot", 
    "349" = "Muut uskonnollisten yhteisojen rakennukset", 
    "351" = "Jaahallit", 
    "352" = "Uimahallit", 
    "353" = "Tennis-, squash- ja sulkapallohallit",
    "354" = "Monitoimi- ja muut urheiluhallit",
    "359" = "Muut urheilu- ja kuntoilurakennukset", 
    "369" = "Muut kokoontumis- rakennukset", 
    "511" = "Peruskoulut, lukiot ja muut", 
    "521" = "Ammatilliset oppilaitokset", 
    "531" = "Korkeakoulu- rakennukset",
    "532" = "Tutkimuslaitosrakennukset", 
    "541" = "Jarjestojen, liittojen, tyonantajien yms.  opetusrakennukset", 
    "549" = "Muualla luokittelemattomat opetusrakennukset", 
    "611" = "Voimalaitosrakennukset", 
    "613" = "Yhdyskuntatekniikan rakennukset", 
    "691" = "Teollisuushallit", 
    "692" = "Teollisuus- ja pienteollisuustalot", 
    "699" = "Muut teollisuuden tuotantorakennukset", 
    "711" = "Teollisuusvarastot",
    "712" = "Kauppavarastot", 
    "719" = "Muut varastorakennukset",
    "721" = "Paloasemat", 
    "722" = "Vaestonsuojat", 
    "723" = "Halytyskeskukset",
    "729" = "Muut palo- ja pelastustoimen rakennukset", 
    "811" = "Navetat, sikalat, kanalat yms.", 
    "819" = "Elainsuojat, ravihevostallit, maneesit", 
    "891" = "Viljankuivaamot ja viljan sailytysrakennukset, siilot", 
    "892" = "Kasvihuoneet", 
    "893" = "Turkistarhat", 
    "899" = "Muut maa-, metsa- ja kalatalouden rakennukset", 
    "931" = "Saunarakennukset",
    "941" = "Talousrakennukset", 
    "999" = "Muut rakennukset", 
    "999999999" = "Puuttuvan tiedon merkki")
  
  KATAKER.key
}

  
#   } else if (which.data == "key.KATAKER") {
#     
#     # Building type identifiers were manually scraped 3.12.2012 from
#     # http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf
#     # (C) HSY 2011 (http://www.hsy.fi)
#     
#     # Get ID descriptions
#     KATAKER.key <- kataker.key()
#     
#     res <- data.frame(list(key = as.integer(names(KATAKER.key)), 
#                            description = KATAKER.key))
#     return(res)
#     
#   } else {
#     stop("Provide proper data name.")
#   }
#   
#   # Unzip the files
#   
# #   .InstallMarginal("utils")
# #   
# #   unzip(destfile)
#   
#   if (which.data == "SeutuRAMAVA") {
#     
#     # Need to read with rgdal, the readShapePoly had problems in
#     # handling this file
#     .InstallMarginal("rgdal")
#     
#     sp <- rgdal::readOGR(".", layer = "SeutuRAMAVA_2010")
#     # Convert to UTF-8 where needed 
#     nams <- c("OMLAJI_1S", "OMLAJI_2S", "OMLAJI_3S", "NIMI", "NIMI_SE")
#     for (nam in nams) {    
#       sp[[nam]] <-  factor(iconv(sp[[nam]], from = "latin1", to = "UTF-8"))
#     }
#   } else if (which.data == "Rakennustietoruudukko") {
#     
#     sp <- gisfi::ReadShape("Rakennustietoruudukko_2010_region.shp")
#     
#   } else if (which.data == "Vaestoruudukko") {
#     
#     sp <- gisfi::ReadShape("Vaestoruudukko_2010_region.shp")
#     
#   }
#   
#   sp
# }


# # The combination of some data and an aching desire for an answer does not
# # ensure that a reasonable answer can be extracted from a given body of
# # data. ~ John Tukey
# 
# #' Retrieve HSY data 
# #'
# #' Retrieves data from Helsinki Region Environmental
# #' Services Authority (Helsingin seudun ymparistopalvelu HSY) 
# #' http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx
# #' For data description (in Finnish) see:
# #' http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf. 
# #' The data copyright (C) HSY 2011.
# #'
# #' Arguments:
# #' @param which.data A string. Specify the name of the retrieved HSY data set. Options: Vaestoruudukko; Rakennustietoruudukko; SeutuRAMAVA; key.KATAKER. The first three are documented in HSY data description document (see above). The key.KATAKER contains manually parsed mapping for building categories from the HSY documentation.
# #'
# #' @return Shape object (from SpatialPolygonsDataFrame class)
# #' @references
# #' See citation("helsinki") 
# #' @author Leo Lahti \email{louhos@@googlegroups.com}
# #' @examples # sp <- GetHSY("Vaestoruudukko")
# #' @keywords utilities
# 
# GetHSY <- function (which.data = "Vaestoruudukko") {
# 
#   # FIXME valiaikaistiedostojen poisto ajon jalkeen, 
#   # ja/tai haku valiaikaiskansioon.
# 
#   data.path <- "http://www.hsy.fi/seututieto/Documents/Paikkatiedot/"
# 
#   if (which.data %in% c("Vaestoruudukko", "Rakennustietoruudukko", "SeutuRAMAVA")) {
# 
#     # Vaestoruudukko: Ruutukohtaista tietoa vaeston lukumaarasta,
#     # ikajakaumasta ja asumisvaljyydesta  
# 
#     # Rakennustietoruudukko: Ruutukohtaista tietoa rakennusten
#     # lukumaarasta, kerrosalasta, kayttotarkoituksesta ja
#     # aluetehokkuudesta. Ruutukoko 500x500 metria.
# 
#     # SeutuRAMAVA: kaupunginosittain summattua tietoa
#     # rakennusmaavarannosta
# 
#     # ESRI
#     destfile <- paste(which.data, "_SHP.zip", sep = "")
#     data.url <- paste(data.path, which.data, "_SHP.zip", sep = "")
#     message(paste("Dowloading HSY data from ", data.url, " in file ", destfile))
#     download.file(data.url, destfile = destfile)
#                   
#   } else if (which.data == "key.KATAKER") {
# 
#     # Building type identifiers were manually scraped 3.12.2012 from
#     # http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf
#     # (C) HSY 2011 (http://www.hsy.fi)
# 
#     # Get ID descriptions
#     KATAKER.key <- kataker.key()
# 
#     res <- data.frame(list(key = as.integer(names(KATAKER.key)), 
#     	   		   description = KATAKER.key))
#     return(res)
# 
#   } else {
#     stop("Provide proper data name.")
#   }
# 
#   # Unzip the files
# 
#   .InstallMarginal("utils")
# 
#   unzip(destfile)
# 
#   if (which.data == "SeutuRAMAVA") {
# 
#     # Need to read with rgdal, the readShapePoly had problems in
#     # handling this file
#     .InstallMarginal("rgdal")
# 
#     sp <- rgdal::readOGR(".", layer = "SeutuRAMAVA_2010")
#     # Convert to UTF-8 where needed 
#     nams <- c("OMLAJI_1S", "OMLAJI_2S", "OMLAJI_3S", "NIMI", "NIMI_SE")
#     for (nam in nams) {    
#       sp[[nam]] <-  factor(iconv(sp[[nam]], from = "latin1", to = "UTF-8"))
#     }
#   } else if (which.data == "Rakennustietoruudukko") {
# 
#     sp <- gisfi::ReadShape("Rakennustietoruudukko_2010_region.shp")
# 
#   } else if (which.data == "Vaestoruudukko") {
# 
#     sp <- gisfi::ReadShape("Vaestoruudukko_2010_region.shp")
# 
#   }
# 
#   sp
# }



