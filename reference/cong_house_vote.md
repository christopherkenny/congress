# Request House Roll Call Vote Information

Request House Roll Call Vote Information

## Usage

``` r
cong_house_vote(
  congress = NULL,
  session = NULL,
  number = NULL,
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

  Congress number to search for. Numeric.

- session:

  Session number (`1` or `2`). Numeric.

- number:

  Roll call vote number. Numeric.

- item:

  Information to request. Can be `'members'`.

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

A tibble or raw HTTP response if clean = FALSE.

## See also

[`cong_request_next()`](http://christophertkenny.com/congress/reference/cong_request_next.md)
to retrieve additional pages of results.

## Examples

``` r
if (FALSE) { # congress::has_congress_key()

cong_house_vote()

cong_house_vote(congress = 119, session = 1, number = 17)

cong_house_vote(congress = 119, session = 1, number = 17, item = 'members')
}
```
