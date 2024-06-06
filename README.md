
# qldyjcost

Cost of Offending Tools for Youth Justice in Queensland

## Purpose

This is a simple, lightweight R package purely for convenience for my
day job as a Senior Data Scientist at the consulting firm [Nous
Group](https://nousgroup.com/) where I frequently conduct evaluations
for Queensland Youth Justice.

## Installation

You can install the development version of `qldyjcost` from GitHub using
the following:

``` r
devtools::install_github("hendersontrent/qldyjcost")
```

## Usage

The core of `qldyjcost` is a data frame of historical costs from
peer-reviewed sources called `yjcosts`. It can be accessed easily via:

``` r
library(qldyjcost)
head(yjcosts)
```

      qasoc_code                   qasoc_description  type  cost      fy
    1          1       Homicide and related offences Court 19674 2016-17
    2          2       Acts intended to cause injury Court  1165 2016-17
    3          3 Sexual assault and related offences Court  6543 2016-17
    4          4         Dangerous or negligent acts Court   508 2016-17
    5          5     Abduction, harassment and other Court  2076 2016-17
    6          6      Robbery, extortion and related Court  3021 2016-17

`yjcosts` contains historical offending costs broken down by offence
seriousness for court costs, police costs, wider social costs, and
custody costs.

`qldyjcost` also contains functionality for adjusting the historical
offending costs to values for a given financial year using inflation.
The `get_cpi` function webscrapes inflation rates from the [Australian
Bureau of
Statistics](https://www.abs.gov.au/statistics/economy/price-indexes-and-inflation/consumer-price-index-australia/)
and automatically cleans it up ready for use:

``` r
cpi <- get_cpi(location = "Australia")
head(cpi)
```

            year inflation_index      fy
    1 1948-09-03             3.7 1948-49
    2 1948-12-03             3.8 1948-49
    3 1949-03-03             3.9 1948-49
    4 1949-06-03             4.0 1948-49
    5 1949-09-03             4.1 1949-50
    6 1949-12-03             4.1 1949-50

Instead of grabbing CPI for the country, we can instead get it for any
capital city:

``` r
cpi_bris <- get_cpi(location = "Brisbane")
head(cpi_bris)
```

            year inflation_index      fy
    1 1948-09-03             3.7 1948-49
    2 1948-12-03             3.7 1948-49
    3 1949-03-03             3.8 1948-49
    4 1949-06-03             3.9 1948-49
    5 1949-09-03             4.0 1949-50
    6 1949-12-03             4.1 1949-50

While this function is useful in isolation, it forms a key component of
the workhorse function of `yjcosts` which is `adjust_costs`.
`adjust_costs` applies inflation adjustments to the offending cost data
to any given financial year. Specifically, it does this by averaging CPI
values for each FY associated with the baseline costs in `yjcosts` as
well as the user-specified FY to adjust to. The interface is incredible
simple. Here is how to adjust costs to FY 2023-24 dollars:

``` r
adj <- adjust_costs(fy = "2023-24", location = "Australia")
head(adj)
```

    # A tibble: 6 × 9
      qasoc_code qasoc_description                   type   cost fy      new_fy  avg_cpi_old avg_cpi_new new_cost
           <dbl> <chr>                               <chr> <dbl> <chr>   <chr>         <dbl>       <dbl>    <dbl>
    1          1 Homicide and related offences       Court 19674 2016-17 2023-24        110.        136.   44012.
    2          2 Acts intended to cause injury       Court  1165 2016-17 2023-24        110.        136.    2605.
    3          3 Sexual assault and related offences Court  6543 2016-17 2023-24        110.        136.   14636.
    4          4 Dangerous or negligent acts         Court   508 2016-17 2023-24        110.        136.    1135.
    5          5 Abduction, harassment and other     Court  2076 2016-17 2023-24        110.        136.    4643.
    6          6 Robbery, extortion and related      Court  3021 2016-17 2023-24        110.        136.    6757.
