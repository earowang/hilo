
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
#>       fit     lwr     upr                 PI
#> 1  -4.153 -6.7623 -1.5439 [-6.7623, -1.5439]
#> 2  -3.233 -5.6694 -0.7975 [-5.6694, -0.7975]
#> 3  -2.314 -4.6111 -0.0165 [-4.6111, -0.0165]
#> 4  -1.394 -3.5940  0.8057 [-3.5940,  0.8057]
#> 5  -0.475 -2.6237  1.6747 [-2.6237,  1.6747]
#> 6   0.445 -1.7035  2.5938 [-1.7035,  2.5938]
#> 7   1.365 -0.8336  3.5631 [-0.8336,  3.5631]
#> 8   2.284 -0.0105  4.5792 [-0.0105,  4.5792]
#> 9   3.204  0.7713  5.6368 [ 0.7713,  5.6368]
#> 10  4.124  1.5183  6.7290 [ 1.5183,  6.7290]
```
