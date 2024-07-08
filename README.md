
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
#> # A tibble: 10 × 13
#>    citation congress description       latest_action_action…¹ latest_action_text
#>    <chr>    <chr>    <chr>             <date>                 <chr>             
#>  1 PN1293   118      Robin Michelle M… 2024-06-20             Cloture motion pr…
#>  2 PN830    118      Patricia L. Lee,… 2024-06-20             Cloture motion pr…
#>  3 PN1355   118      Charles J. Willo… 2024-06-20             Cloture motion pr…
#>  4 PN1343   118      Stephanie Sander… 2024-06-20             Confirmed by the …
#>  5 PN1851   118      <NA>              2024-06-20             Received in the S…
#>  6 PN1847   118      <NA>              2024-06-20             Received in the S…
#>  7 PN1850   118      <NA>              2024-06-20             Received in the S…
#>  8 PN1842   118      <NA>              2024-06-20             Received in the S…
#>  9 PN1849   118      <NA>              2024-06-20             Received in the S…
#> 10 PN1848   118      <NA>              2024-06-20             Received in the S…
#> # ℹ abbreviated name: ¹​latest_action_action_date
#> # ℹ 8 more variables: nomination_type_is_civilian <chr>, number <chr>,
#> #   organization <chr>, part_number <chr>, received_date <date>,
#> #   update_date <dttm>, url <chr>, nomination_type_is_military <chr>
```

You can request up to 250 results, using `limit`. Once a request has
been made, you can request the next set by using the `offset` argument:

``` r
cong_nomination(limit = 10, offset = 10)
#> # A tibble: 10 × 13
#>    citation congress latest_action_action_date latest_action_text               
#>    <chr>    <chr>    <date>                    <chr>                            
#>  1 PN1847   118      2024-06-20                Received in the Senate and refer…
#>  2 PN1805   118      2024-06-20                Committee on the Judiciary. Hear…
#>  3 PN1807   118      2024-06-20                Committee on the Judiciary. Hear…
#>  4 PN1842   118      2024-06-20                Received in the Senate and refer…
#>  5 PN1808   118      2024-06-20                Committee on the Judiciary. Hear…
#>  6 PN1850   118      2024-06-20                Received in the Senate and refer…
#>  7 PN1806   118      2024-06-20                Committee on the Judiciary. Hear…
#>  8 PN1461   118      2024-06-20                Cloture invoked in Senate by Yea…
#>  9 PN1849   118      2024-06-20                Received in the Senate and refer…
#> 10 PN1851   118      2024-06-20                Received in the Senate and refer…
#> # ℹ 9 more variables: nomination_type_is_military <chr>, number <chr>,
#> #   organization <chr>, part_number <chr>, received_date <date>,
#> #   update_date <dttm>, url <chr>, description <chr>,
#> #   nomination_type_is_civilian <chr>
```

You can also request the next set using the `cong_request_next()`
function:

``` r
cong_nomination(limit = 10) |> 
  cong_request_next()
#> # A tibble: 20 × 13
#>    citation congress description       latest_action_action…¹ latest_action_text
#>    <chr>    <chr>    <chr>             <date>                 <chr>             
#>  1 PN1293   118      Robin Michelle M… 2024-06-20             Cloture motion pr…
#>  2 PN830    118      Patricia L. Lee,… 2024-06-20             Cloture motion pr…
#>  3 PN1355   118      Charles J. Willo… 2024-06-20             Cloture motion pr…
#>  4 PN1343   118      Stephanie Sander… 2024-06-20             Confirmed by the …
#>  5 PN1851   118      <NA>              2024-06-20             Received in the S…
#>  6 PN1847   118      <NA>              2024-06-20             Received in the S…
#>  7 PN1850   118      <NA>              2024-06-20             Received in the S…
#>  8 PN1842   118      <NA>              2024-06-20             Received in the S…
#>  9 PN1849   118      <NA>              2024-06-20             Received in the S…
#> 10 PN1848   118      <NA>              2024-06-20             Received in the S…
#> 11 PN1847   118      <NA>              2024-06-20             Received in the S…
#> 12 PN1805   118      Karla M. Campbel… 2024-06-20             Committee on the …
#> 13 PN1807   118      Mary Kay Lanthie… 2024-06-20             Committee on the …
#> 14 PN1842   118      <NA>              2024-06-20             Received in the S…
#> 15 PN1808   118      Julia M. Lipez, … 2024-06-20             Committee on the …
#> 16 PN1850   118      <NA>              2024-06-20             Received in the S…
#> 17 PN1806   118      Catherine Henry,… 2024-06-20             Committee on the …
#> 18 PN1461   118      Nancy L. Maldona… 2024-06-20             Cloture invoked i…
#> 19 PN1849   118      <NA>              2024-06-20             Received in the S…
#> 20 PN1851   118      <NA>              2024-06-20             Received in the S…
#> # ℹ abbreviated name: ¹​latest_action_action_date
#> # ℹ 8 more variables: nomination_type_is_civilian <chr>, number <chr>,
#> #   organization <chr>, part_number <chr>, received_date <date>,
#> #   update_date <dttm>, url <chr>, nomination_type_is_military <chr>
```

## Supported Endpoints:

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

## Authentication

To sign up for an API key, visit the [Congress.gov
API](https://api.congress.gov/sign-up/) sign-up website.

Once you have your key, you can set it in your environment as
`CONGRESS_KEY`. You can:

1.  Add this directly to your `.Renviron` file with a line like so

``` r
CONGRESS_KEY='yourkey'
```

If doing this, I recommend using `usethis::edit_r_environ()` to ensure
that you open the correct .Renviron file.

2.  Set this in you current R session with
    `Sys.setenv(CONGRESS_KEY='yourkey')`.

3.  Set this using the `congress::set_congress_key()` function. To save
    this for future sessions, run with `install = TRUE`.
