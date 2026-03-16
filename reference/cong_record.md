# Request Congressional Record Information

Request Congressional Record Information

## Usage

``` r
cong_record(
  year = NULL,
  month = NULL,
  day = NULL,
  limit = 20,
  offset = 0,
  format = "json",
  clean = TRUE
)
```

## Arguments

- year:

  integer for year

- month:

  integer for month

- day:

  integer for day of month

- limit:

  number of records to return. Default is 20. Will be truncated to
  between 1 and 250.

- offset:

  number of records to skip. Default is 0. Must be non-negative.

- format:

  Output format for `clean = FALSE`. One of `xml` or `json`.

- clean:

  Default is TRUE. Should output be returned as a `tibble` (`TRUE`) or
  requested `format`.

## Value

a [`tibble::tibble`](https://tibble.tidyverse.org/reference/tibble.html)
or HTTP response if `clean = FALSE`

## See also

[`cong_request_next()`](http://christophertkenny.com/congress/reference/cong_request_next.md)
to retrieve additional pages of results.

## Examples

``` r
if (FALSE) { # congress::has_congress_key()

# Requires API Key

cong_record()

cong_record(year = 2022, month = 6, day = 28)
}
```
