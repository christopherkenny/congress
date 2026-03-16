# Request Hearing Information

Request Hearing Information

## Usage

``` r
cong_hearing(
  congress = NULL,
  chamber = NULL,
  number = NULL,
  limit = 20,
  offset = 0,
  format = "json",
  clean = TRUE
)
```

## Arguments

- congress:

  Congress number to search for. 81 or later are supported.

- chamber:

  Chamber name. Can be `'house'`, `'senate'`, or `'nochamber'`.

- number:

  Jacket number for the hearing. Character (or numeric).

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

cong_hearing()

cong_hearing(congress = 116)

cong_hearing(chamber = 'house')

cong_hearing(congress = 116, chamber = 'house')

cong_hearing(congress = 116, chamber = 'house', number = 41365)
}
```
