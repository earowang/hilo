
<!-- README.md is generated from README.Rmd. Please edit that file -->
tsibble
=======

[![Travis-CI Build Status](https://travis-ci.org/earowang/hilo.svg?branch=master)](https://travis-ci.org/earowang/hilo) [![Coverage Status](https://img.shields.io/codecov/c/github/earowang/hilo/master.svg)](https://codecov.io/github/earowang/hilo?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/hilo)](https://cran.r-project.org/package=hilo)

The **hilo** package attempts to build a S3 infrastructure for ranges/intervals. Upon the S3 class `range`, one could define confidence/prediction intervals in a compact way, i.e. one column instead of three (including lower, upper and level). It provides the back-end for `tbl_forecast` in the [tsibble](http://pkg.earo.me/tsibble) package.

Installation
------------

You could install the development version from Github using

``` r
# install.packages("devtools")
devtools::install_github("earowang/hilo")
```

How it works
------------

``` r
library(hilo)
dat <- data.frame(t = 1:5, value = 1:5 + rnorm(5))
newdat <- data.frame(t = 6:10)
fit <- lm(value ~ t, data = dat)
pred <- as.data.frame(predict(fit, newdata = newdat, interval = "prediction"))
pred$PI <- tie(lower = pred$lwr, upper = pred$upr, level = 95L)
pred
#>    fit    lwr   upr              PI
#> 1 4.65 -0.330  9.62 [-0.330,  9.62]
#> 2 5.18 -0.569 10.92 [-0.569, 10.92]
#> 3 5.71 -0.897 12.31 [-0.897, 12.31]
#> 4 6.24 -1.284 13.76 [-1.284, 13.76]
#> 5 6.77 -1.711 15.25 [-1.711, 15.25]
```
