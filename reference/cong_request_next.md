# Request next set of responses

Request next set of responses

## Usage

``` r
cong_request_next(response, max_req = 1)
```

## Arguments

- response:

  A [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
  from a `cong_*` function

- max_req:

  A max number of additional requests to make. Default is 1.

## Value

a tibble with responses bound by row to new results

## Examples

``` r
if (FALSE) { # congress::has_congress_key()
# Requires API Key

cong_bill() |>
  cong_request_next()
}
```
