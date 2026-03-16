# Request Committee Information

Request Committee Information

## Usage

``` r
cong_committee(
  congress = NULL,
  chamber = NULL,
  committee = NULL,
  item = NULL,
  from_date = NULL,
  to_date = NULL,
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

  Chamber name. Can be `'house'`, `'senate'`, or `'joint'`.

- committee:

  Code identifying committee. Character.

- item:

  Information to request. Can be `'bills'`, `'reports'`,
  `'nominations'`, `'house-communication'`, or `'senate-communication'`.

- from_date:

  start date for search, e.g. `'2022-04-01'`. Defaults to most recent.

- to_date:

  end date for search, e.g. `'2022-04-03'`. Defaults to most recent.

- limit:

  number of records to return. Default is 20. Will be truncated to
  between 1 and 250.

- offset:

  number of records to skip. Default is 0. Must be non-negative.

- format:

  Output format for `clean = FALSE`. One of `xml` or `json`.

- clean:

  Default is `TRUE`. Should output be returned as a `tibble` (`TRUE`) or
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

cong_committee()

cong_committee(congress = 117)

cong_committee(chamber = 'house')

cong_committee(congress = 117, chamber = 'house')

cong_committee(chamber = 'house', committee = 'hsed10')

cong_committee(chamber = 'house', committee = 'hspw00', item = 'house-communication')

cong_committee(chamber = 'senate', committee = 'jsec03')

cong_committee(chamber = 'senate', committee = 'slpo00', item = 'bills')

cong_committee(chamber = 'senate', committee = 'slpo00', item = 'senate-communication')
}
```
