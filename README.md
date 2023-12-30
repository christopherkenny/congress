
<!-- README.md is generated from README.Rmd. Please edit that file -->

# congress <img src="man/figures/logo.png" align="right" height="130" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/congress)](https://CRAN.R-project.org/package=congress)
[![congress status
badge](https://christopherkenny.r-universe.dev/badges/congress)](https://christopherkenny.r-universe.dev/congress)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/christopherkenny/congress/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/christopherkenny/congress/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/christopherkenny/congress/branch/main/graph/badge.svg)](https://app.codecov.io/gh/christopherkenny/congress?branch=main)
<!-- badges: end -->

`congress` provides a *mostly* tidy interface to the Congress.gov API,
available at <https://github.com/LibraryOfCongress/api.congress.gov/>.
It provides a simple R interface for downloading and working with
actions, bills, nominations, and more from Congress.

## Installation

You can install the stable version of `congress` from
[CRAN](https://CRAN.R-project.org/package=congress) with:

``` r
install.packages('congress')
```

You can install the development version of congress from
[GitHub](https://github.com/) with:

``` r
# install.packages('devtools')
devtools::install_github('christopherkenny/congress')
```

## Example

To get the most recent `nomination`s, we can use the `cong_nomination()`
function. By default, it gets the most recent 20. We request here, the
most recent 10.

``` r
library(congress)

cong_nomination(limit = 10)
#> # A tibble: 10 × 12
#>    citation congress description       latest_action_action…¹ latest_action_text
#>    <chr>    <chr>    <chr>             <date>                 <chr>             
#>  1 PN1025   118      Jennifer L. Fain… 2023-12-20             Confirmed by the …
#>  2 PN548    118      Tobin John Bradl… 2023-12-20             Confirmed by the …
#>  3 PN1044   118      Spencer Bachus I… 2023-12-20             Confirmed by the …
#>  4 PN1020   118      John A. Kazen, o… 2023-12-20             By unanimous cons…
#>  5 PN742    118      David E. White, … 2023-12-20             Confirmed by the …
#>  6 PN871    118      Rion J. Ramirez,… 2023-12-20             Confirmed by the …
#>  7 PN918    118      William Brodsky,… 2023-12-20             Confirmed by the …
#>  8 PN832    118      Tadd M. Johnson,… 2023-12-20             Confirmed by the …
#>  9 PN805    118      Bradford Pentony… 2023-12-20             Confirmed by the …
#> 10 PN740    118      Mark Toshiro Uye… 2023-12-20             Confirmed by the …
#> # ℹ abbreviated name: ¹​latest_action_action_date
#> # ℹ 7 more variables: nomination_type_is_civilian <chr>, number <chr>,
#> #   organization <chr>, part_number <chr>, received_date <date>,
#> #   update_date <dttm>, url <chr>
```

### Supported Endpoints:

This package is designed for `v3` of the [Congress.gov
API](https://github.com/LibraryOfCongress/api.congress.gov/). It
currently supports the following endpoints:

- bills with `cong_bill()`
- amendments with `cong_amendment()`
- summaries with `cong_summaries()`
- congresses with `cong_congress()`
- members with `cong_member()`
- committees with `cong_committee()`
- committee reports with `cong_committee_report()`
- committee prints with `cong_committee_print()`
- committee meetings with `cong_committee_meeting()`
- Congressional Records with `cong_record()`
- Daily Congressional Records with `cong_daily_record()`
- Bound Congressional Records with `cong_bound_record()`
- House communications with `cong_house_communication()`
- Senate communications with `cong_senate_communication()`
- nominations with `cong_nomination()`
- treaties with `cong_treaty()`
- hearings with `cong_hearing()`
