stats510\_2
================
Christoper Chan
December 4, 2018

2.1 Moving Average Models
-------------------------

-   1st order MA(1) = *x*<sub>*t*</sub> = *μ* + *w*<sub>*t*</sub> + *θ*<sub>1</sub>*w*<sub>*t* − 1</sub>
    -   qth order MA(*q*) = *x*<sub>*t*</sub> = *μ* + *w*<sub>*t*</sub> + *θ*<sub>1</sub>*w*<sub>*t* − 1</sub> + *θ*<sub>2</sub>*w*<sub>*t* − 2</sub> + ... + *θ*<sub>*q*</sub>*w*<sub>*t* − *q*</sub>
    -   Properties:
        -   Mean *E*(*x*<sub>*t*</sub>)=*μ*
        -   *V**a**r*(*x*<sub>*t*</sub>)=*σ*<sub>*w*</sub><sup>2</sup>(1 + *θ*<sub>1</sub><sup>2</sup>)
        -   ACF =
            $$rho\_1 = \\frac{\\theta\_1}{1 + \\theta^2\_1}$$
             and *ρ*<sub>*h*</sub> = 0 for *h* ≥ 2
            -   For MA(q): nonzero AC for first q lags and *A**C* = 0 for $lags\\legq$
