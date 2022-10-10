
<!-- README.md is generated from README.Rmd. Please edit that file -->

# congress <img src="man/figures/logo.png" align="right" height="130" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/christopherkenny/congress/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/christopherkenny/congress/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`congress` provides a *mostly* tidy interface to the Congress.gov API,
available at <https://github.com/LibraryOfCongress/api.congress.gov/>.
It provides a simple R interface for downloading and working with
actions, bills, nominations, and more from Congress.

## Installation

You can install the development version of congress from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("christopherkenny/congress")
```

## Example

To get the most recent `nomination`s, we can use the `cong_nomination()`
function. By default, it gets the most recent 20. We request here, the
most recent 10.

``` r
library(congress)

cong_nomination(limit = 10)
#> # A tibble: 10 × 13
#>    citation congress description  lates…¹ lates…² nomin…³ nomin…⁴ nomin…⁵ number
#>    <chr>    <chr>    <chr>        <chr>   <chr>   <chr>   <chr>   <chr>   <chr> 
#>  1 PN2678   117      " "          2022-0… Receiv… FALSE   TRUE    "U.S. … 2678  
#>  2 PN2673   117      " "          2022-0… Receiv… FALSE   TRUE    "U.S. … 2673  
#>  3 PN2675   117      " "          2022-0… Receiv… FALSE   TRUE    "U.S. … 2675  
#>  4 PN2677   117      " "          2022-0… Receiv… FALSE   TRUE    "U.S. … 2677  
#>  5 PN2676   117      " "          2022-0… Receiv… FALSE   TRUE    "U.S. … 2676  
#>  6 PN2674   117      " "          2022-0… Receiv… FALSE   TRUE    "U.S. … 2674  
#>  7 PN2672   117      "Ronald T. … 2022-0… Receiv… TRUE    FALSE   "Gover… 2672  
#>  8 PN2670   117      "Todd E. Ed… 2022-0… Receiv… TRUE    FALSE   "Gover… 2670  
#>  9 PN2666   117      "Travis Hil… 2022-0… Receiv… TRUE    FALSE   "Gover… 2666  
#> 10 PN2669   117      " "          2022-0… Receiv… FALSE   TRUE    "U.S. … 2669  
#> # … with 4 more variables: part_number <chr>, received_date <chr>,
#> #   update_date <chr>, url <chr>, and abbreviated variable names
#> #   ¹​latest_action_action_date, ²​latest_action_text,
#> #   ³​nomination_type_is_civilian, ⁴​nomination_type_is_military,
#> #   ⁵​nomination_type_name
```

### Supported Endpoints:

This package is designed for `v3` of the [Congress.gov
API](https://github.com/LibraryOfCongress/api.congress.gov/). It
currently supports the following endpoints:

-   bill with `cong_bill()`
-   amendments with `cong_amendment()`
-   summaries with `cong_summaries()`
-   congress with `cong_congress()`
-   member with `cong_member()`
-   committee with `cong_committee()`
-   committee report with `cong_committee_report()`
-   Congressional Record with `cong_record()`
-   House communication with `cong_communication()`
-   nomination with `cong_nomination()`
-   treaty with `cong_treaty()`
