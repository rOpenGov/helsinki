/usr/bin/R CMD BATCH document.R
/usr/bin/R CMD build ../../
/usr/bin/R CMD check --as-cran helsinki_0.9.28.tar.gz
/usr/bin/R CMD INSTALL helsinki_0.9.28.tar.gz
