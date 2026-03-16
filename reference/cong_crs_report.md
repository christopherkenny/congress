# Request Congressional Research Service (CRS) Report Information

Request Congressional Research Service (CRS) Report Information

## Usage

``` r
cong_crs_report(
  crs_id = NULL,
  from_date = NULL,
  to_date = NULL,
  limit = 20,
  offset = 0,
  format = "json",
  clean = TRUE
)
```

## Arguments

- crs_id:

  Optional CRS identifier. If provided, returns a specific report.

- from_date:

  Start date for search, e.g. `'2022-01-01'`. Optional.

- to_date:

  End date for search, e.g. `'2022-01-31'`. Optional.

- limit:

  Number of records to return. Default is 20. Will be truncated to
  between 1 and 250.

- offset:

  Number of records to skip. Default is 0. Must be non-negative.

- format:

  Output format for `clean = FALSE`. One of `'json'` or `'xml'`.

- clean:

  Should output be returned as a tibble (`TRUE`) or requested format
  (`FALSE`). Default is `TRUE`.

## Value

A [`tibble::tibble`](https://tibble.tidyverse.org/reference/tibble.html)
or raw HTTP response if `clean = FALSE`.

## See also

[`cong_request_next()`](http://christophertkenny.com/congress/reference/cong_request_next.md)
to retrieve additional pages of results.

## Examples

``` r
if (FALSE) { # congress::has_congress_key()
# Requires API Key

cong_crs_report()

cong_crs_report(crs_id = '93-792')
}
```
