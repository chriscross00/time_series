stats510\_1
================
Christoper Chan
December 1, 2018

1.1 Overview
------------

-   AR(1) model: ![x\_{t} = \\delta + \\phi\_{1}x\_{t-1} + w\_{t}](https://latex.codecogs.com/png.latex?x_%7Bt%7D%20%3D%20%5Cdelta%20%2B%20%5Cphi_%7B1%7Dx_%7Bt-1%7D%20%2B%20w_%7Bt%7D "x_{t} = \delta + \phi_{1}x_{t-1} + w_{t}")
    -   Same properties of linear regression

1.2 Sample ACF and Properities of AR(1) Model
---------------------------------------------

-   Weakly stationary series requirements:
    1.  Mean ![E(x\_{t})](https://latex.codecogs.com/png.latex?E%28x_%7Bt%7D%29 "E(x_{t})") is same for all *t*
    2.  Variance of ![x\_t](https://latex.codecogs.com/png.latex?x_t "x_t") is same for all *t*
    3.  Corvariance and correlation between ![x\_t](https://latex.codecogs.com/png.latex?x_t "x_t") and ![x\_{t-h}](https://latex.codecogs.com/png.latex?x_%7Bt-h%7D "x_{t-h}") is same for all *t*
-   Autocorrelation function (ACF) = gives correlation between ![x\_t](https://latex.codecogs.com/png.latex?x_t "x_t") and ![x\_{t-h}](https://latex.codecogs.com/png.latex?x_%7Bt-h%7D "x_{t-h}") for ![h = 1, 2...n](https://latex.codecogs.com/png.latex?h%20%3D%201%2C%202...n "h = 1, 2...n")
    -   ACF = ![\\frac{Cov(x\_t, x\_{t-h})}{s(x\_t)s(x\_t)} = \\frac{Cov(x\_t, x\_{t-h})}{Var(x\_t)}](https://latex.codecogs.com/png.latex?%5Cfrac%7BCov%28x_t%2C%20x_%7Bt-h%7D%29%7D%7Bs%28x_t%29s%28x_t%29%7D%20%3D%20%5Cfrac%7BCov%28x_t%2C%20x_%7Bt-h%7D%29%7D%7BVar%28x_t%29%7D "\frac{Cov(x_t, x_{t-h})}{s(x_t)s(x_t)} = \frac{Cov(x_t, x_{t-h})}{Var(x_t)}")
-   Properties of AR(1) model:
    -   Mean(![\\mu](https://latex.codecogs.com/png.latex?%5Cmu "\mu")) = ![\\frac{\\delta}{1-\\phi\_1}](https://latex.codecogs.com/png.latex?%5Cfrac%7B%5Cdelta%7D%7B1-%5Cphi_1%7D "\frac{\delta}{1-\phi_1}")
    -   Var(![x\_t](https://latex.codecogs.com/png.latex?x_t "x_t")) = ![\\frac{\\sigma^2\_w}{1-\\phi^2\_1}](https://latex.codecogs.com/png.latex?%5Cfrac%7B%5Csigma%5E2_w%7D%7B1-%5Cphi%5E2_1%7D "\frac{\sigma^2_w}{1-\phi^2_1}")
    -   Cor(![\\rho\_h](https://latex.codecogs.com/png.latex?%5Crho_h "\rho_h")) = ![\\phi^2\_1](https://latex.codecogs.com/png.latex?%5Cphi%5E2_1 "\phi^2_1")
-   Create stationary series by first differences (![y\_t = x\_t - x\_{t-1}](https://latex.codecogs.com/png.latex?y_t%20%3D%20x_t%20-%20x_%7Bt-1%7D "y_t = x_t - x_{t-1}"))

1.3 Coded Examples
------------------

``` r
library(tidyverse)
library(forecast)
```

``` r
my_quakes <- scan('data/quakes.txt')
head(my_quakes)
```

    ## [1] 840 157 145  44  33 121

``` r
quakes = ts(my_quakes)
```

Honestly, I've looked around for ways to plot this in ggplot2 and I'm just not sure. Because there is no X component of dataset quakes, I'm not sure how

``` r
plot(quakes, type='b')
```

![](stats510_1_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
lag.plot(quakes, lags=1, do.lines=F)
```

![](stats510_1_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
acf(quakes, xlim=c(1,20))
```

![](stats510_1_files/figure-markdown_github/unnamed-chunk-5-1.png)

Regression of quakes$x and created variable of lag\_1

``` r
quakes_lag1 <- lag(my_quakes, 1)

y = cbind(my_quakes, quakes_lag1)
ar1_lr <- lm(y[,1]~y[,2])
summary(ar1_lr)
```

    ## 
    ## Call:
    ## lm(formula = y[, 1] ~ y[, 2])
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -432.68 -303.62  -88.72  222.02 1464.08 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 446.2549    76.8811   5.804 2.72e-07 ***
    ## y[, 2]       -0.0355     0.1293  -0.275    0.785    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 402.9 on 59 degrees of freedom
    ##   (1 observation deleted due to missingness)
    ## Multiple R-squared:  0.001276,   Adjusted R-squared:  -0.01565 
    ## F-statistic: 0.07537 on 1 and 59 DF,  p-value: 0.7846
