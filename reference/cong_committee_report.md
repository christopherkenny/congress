# Request Committee Report Information

Request Committee Report Information

## Usage

``` r
cong_committee_report(
  congress = NULL,
  type = NULL,
  number = NULL,
  item = NULL,
  conference = FALSE,
  limit = 20,
  offset = 0,
  format = "json",
  clean = TRUE
)
```

## Arguments

- congress:

  Congress number to search for. 81 or later are supported.

- type:

  Type of committee report. Can be `'hrpt'`, `'srpt'`, or `'erpt'`.

- number:

  Committee report assigned number. Numeric.

- item:

  Information to request. Can be `'text'`.

- conference:

  Filter to conference reports. Default is `FALSE`.

- limit:

  number of records to return. Default is 20. Will be truncated to
  between 1 and 250.

- offset:

  number of records to skip. Default is 0. Must be non-negative.

- format:

  Output format for `clean = FALSE`. One of `xml` or `json`.

- clean:

  Default is TRUE. Should output be returned as a `tibble` if
  `clean = TRUE` or requested `format`.

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

cong_committee_report()

cong_committee_report(conference = TRUE)

cong_committee_report(congress = 116)

cong_committee_report(congress = 116, type = 'hrpt')

cong_committee_report(congress = 116, type = 'hrpt', number = 617)

cong_committee_report(congress = 116, type = 'hrpt', number = 617, item = 'text')
}
```
