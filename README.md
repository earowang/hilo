
<!-- README.md is generated from README.Rmd. Please edit that file -->
hilo
====

[![Travis-CI Build Status](https://travis-ci.org/earowang/hilo.svg?branch=master)](https://travis-ci.org/earowang/hilo) [![Coverage Status](https://img.shields.io/codecov/c/github/earowang/hilo/master.svg)](https://codecov.io/github/earowang/hilo?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/hilo)](https://cran.r-project.org/package=hilo)

A simple class for ranges/intervals. Upon the S3 class `range`, one could define confidence/prediction intervals in a compact way, i.e. one column instead of three (including lower, upper and level). It provides the back-end for `tbl_forecast` in the [tsibble](http://pkg.earo.me/tsibble) package.

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
x <- rnorm(15)
y <- x + rnorm(15)
newdat <- data.frame(x = seq(-3, 3, length.out = 10))
pred <- as.data.frame(predict(lm(y ~ x), newdat, interval = "prediction"))
pred$PI <- tie(lower = pred$lwr, upper = pred$upr, level = 95L)
pred
#>     fit   lwr   upr             PI
#> 1  -4.2 -6.76 -1.54 [-6.76, -1.54]
#> 2  -3.2 -5.67 -0.80 [-5.67, -0.80]
#> 3  -2.3 -4.61 -0.02 [-4.61, -0.02]
#> 4  -1.4 -3.59  0.81 [-3.59,  0.81]
#> 5  -0.5 -2.62  1.67 [-2.62,  1.67]
#> 6   0.4 -1.70  2.59 [-1.70,  2.59]
#> 7   1.4 -0.83  3.56 [-0.83,  3.56]
#> 8   2.3 -0.01  4.58 [-0.01,  4.58]
#> 9   3.2  0.77  5.64 [ 0.77,  5.64]
#> 10  4.1  1.52  6.73 [ 1.52,  6.73]
```
