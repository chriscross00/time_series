stats510\_3
================
Christopher Chan
December 9, 2018

3.1 Non-Seasonal Moving Average
-------------------------------

-   ARIMA models(Box-Jekins models) = may contain AR terms, MA terms and/or differencing operations
    -   Specified in the order (AR order, differencing, MA order)
        -   ie (1, 2, 3) = AR(1), 2nd difference, MA(3)

3.2 Diagnostics
---------------

-   Lijung-Box

    ![Q(m) = n(n+2) \\sum^m\_{j=1}\\frac{r^2\_j}{n-j}](https://latex.codecogs.com/png.latex?Q%28m%29%20%3D%20n%28n%2B2%29%20%5Csum%5Em_%7Bj%3D1%7D%5Cfrac%7Br%5E2_j%7D%7Bn-j%7D "Q(m) = n(n+2) \sum^m_{j=1}\frac{r^2_j}{n-j}")

    -   Test residuals for siginficance.

``` r
library(tidyverse)
library(forecast)
library(tseries)
```
