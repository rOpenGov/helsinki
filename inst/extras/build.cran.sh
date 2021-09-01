#~/bin/R-4.0.0/bin/R CMD BATCH document.R
~/bin/R-4.0.0/bin/R CMD build ../../
~/bin/R-4.0.0/bin/R CMD check --as-cran helsinki_1.0.3.tar.gz
~/bin/R-4.0.0/bin/R CMD INSTALL helsinki_1.0.3.tar.gz
