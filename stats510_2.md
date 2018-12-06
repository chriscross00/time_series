stats510\_2
================
Christoper Chan
December 4, 2018

2.1 Moving Average Models
-------------------------

-   1st order MA(1) = ![x\_t = \\mu + w\_t + \\theta\_{1}w\_{t-1}](https://latex.codecogs.com/png.latex?x_t%20%3D%20%5Cmu%20%2B%20w_t%20%2B%20%5Ctheta_%7B1%7Dw_%7Bt-1%7D "x_t = \mu + w_t + \theta_{1}w_{t-1}")
    -   qth order MA(![q](https://latex.codecogs.com/png.latex?q "q")) = ![x\_t = \\mu + w\_t + \\theta\_{1}w\_{t-1} + \\theta\_{2}w\_{t-2} + ... + \\theta\_{q}w\_{t-q}](https://latex.codecogs.com/png.latex?x_t%20%3D%20%5Cmu%20%2B%20w_t%20%2B%20%5Ctheta_%7B1%7Dw_%7Bt-1%7D%20%2B%20%5Ctheta_%7B2%7Dw_%7Bt-2%7D%20%2B%20...%20%2B%20%5Ctheta_%7Bq%7Dw_%7Bt-q%7D "x_t = \mu + w_t + \theta_{1}w_{t-1} + \theta_{2}w_{t-2} + ... + \theta_{q}w_{t-q}")
    -   Properties:
        -   Mean ![E(x\_t) = \\mu](https://latex.codecogs.com/png.latex?E%28x_t%29%20%3D%20%5Cmu "E(x_t) = \mu")
        -   ![Var(x\_t) = \\sigma^2\_w(1 + \\theta^2\_1)](https://latex.codecogs.com/png.latex?Var%28x_t%29%20%3D%20%5Csigma%5E2_w%281%20%2B%20%5Ctheta%5E2_1%29 "Var(x_t) = \sigma^2_w(1 + \theta^2_1)")
        -   ACF =

            ![rho\_1 = \\frac{\\theta\_1}{1 + \\theta^2\_1}](https://latex.codecogs.com/png.latex?rho_1%20%3D%20%5Cfrac%7B%5Ctheta_1%7D%7B1%20%2B%20%5Ctheta%5E2_1%7D "rho_1 = \frac{\theta_1}{1 + \theta^2_1}")

             and ![\\rho\_h = 0](https://latex.codecogs.com/png.latex?%5Crho_h%20%3D%200 "\rho_h = 0") for ![h\\geq2](https://latex.codecogs.com/png.latex?h%5Cgeq2 "h\geq2")
            -   For MA(q): nonzero AC for first q lags and ![AC = 0](https://latex.codecogs.com/png.latex?AC%20%3D%200 "AC = 0") for ![lags\\legq](https://latex.codecogs.com/png.latex?lags%5Clegq "lags\legq")

``` r
library(tidyverse)
library(zoo)
```

``` r
ma2 <- ARMAacf(ma=c(0.5, 0.3), lag.max=10)
ma2
```

    ##         0         1         2         3         4         5         6 
    ## 1.0000000 0.4850746 0.2238806 0.0000000 0.0000000 0.0000000 0.0000000 
    ##         7         8         9        10 
    ## 0.0000000 0.0000000 0.0000000 0.0000000

``` r
lags <- data.frame(0:10)
s <- cbind(ma2, lags, make.row.names = T)
print(s)
```

    ##          ma2 X0.10 make.row.names
    ## 0  1.0000000     0           TRUE
    ## 1  0.4850746     1           TRUE
    ## 2  0.2238806     2           TRUE
    ## 3  0.0000000     3           TRUE
    ## 4  0.0000000     4           TRUE
    ## 5  0.0000000     5           TRUE
    ## 6  0.0000000     6           TRUE
    ## 7  0.0000000     7           TRUE
    ## 8  0.0000000     8           TRUE
    ## 9  0.0000000     9           TRUE
    ## 10 0.0000000    10           TRUE

``` r
ggplot(s, aes(lags, ma2)) +
  geom_point() +
  geom_line() +
  ylab('r') +
  ggtitle('ACF for MA(2) with theta1 = 0.5,theta2=0.3')
```

    ## Don't know how to automatically pick scale for object of type data.frame. Defaulting to continuous.

![](stats510_2_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
xc <- arima.sim(n=150, list(ma=c(0.5, 0.3)))
x <- as_tibble(xc + 10)

plot(x, type='b')
```

![](stats510_2_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
autoplot.zoo(x, geom = 'point') + 
  geom_line() +
  ylab('Time')
```

    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.

![](stats510_2_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
  ggtitle('Simulated MA(2) Series')
```

    ## $title
    ## [1] "Simulated MA(2) Series"
    ## 
    ## $subtitle
    ## NULL
    ## 
    ## attr(,"class")
    ## [1] "labels"

``` r
acf(x, xlim = c(1,10), main = 'ACF for simulated MA(2) data')
```

![](stats510_2_files/figure-markdown_github/unnamed-chunk-6-1.png)

2.2 Partial Autocorrelation Function (PACF)
-------------------------------------------

-   qth order PACF =

    ![\\frac{Cov(x\_t, x\_{t-q}|x\_{t-1},... x\_{t-q-1})}{\\sqrt{Var(x\_t|x\_{t-1},... x\_{t-q-1})Var(x\_{t-q}|x\_{t-1},... x\_{t-q-1})}}](https://latex.codecogs.com/png.latex?%5Cfrac%7BCov%28x_t%2C%20x_%7Bt-q%7D%7Cx_%7Bt-1%7D%2C...%20x_%7Bt-q-1%7D%29%7D%7B%5Csqrt%7BVar%28x_t%7Cx_%7Bt-1%7D%2C...%20x_%7Bt-q-1%7D%29Var%28x_%7Bt-q%7D%7Cx_%7Bt-1%7D%2C...%20x_%7Bt-q-1%7D%29%7D%7D "\frac{Cov(x_t, x_{t-q}|x_{t-1},... x_{t-q-1})}{\sqrt{Var(x_t|x_{t-1},... x_{t-q-1})Var(x_{t-q}|x_{t-1},... x_{t-q-1})}}")

    -   For AR model PACF is order of the model

2.3 Notational conventions
--------------------------
