# Request Member Information

This provides three search paths under the `/member` endpoint.

1.  By `bioguide`, which can be subset with `item`

2.  By `congress`, which can be subset with `state` and `district`

3.  By `state`, which can be subset with `district`

## Usage

``` r
cong_member(
  bioguide = NULL,
  item = NULL,
  congress = NULL,
  state = NULL,
  district = NULL,
  current_member = FALSE,
  from_date = NULL,
  to_date = NULL,
  limit = 20,
  offset = 0,
  format = "json",
  clean = TRUE
)
```

## Arguments

- bioguide:

  Bioguide identifier for a member of Congress.

- item:

  Information to request. Can be `'sponsored-legislation'` or
  `'cosponsored-legislation'`

- congress:

  Congress number.

- state:

  State abbreviation. e.g. `'CA'`.

- district:

  Congressional district number. e.g. `1`.

- current_member:

  Logical. Should only current members be returned? Default is `FALSE`.

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

  Default is TRUE. Should output be returned as a `tibble` (`TRUE`) or
  requested `format`.

## Value

a [`tibble::tibble`](https://tibble.tidyverse.org/reference/tibble.html)
or HTTP response if `clean = FALSE`

## Details

If an invalid set of these are provided, they will be used in the above
order.

## See also

[`cong_request_next()`](http://christophertkenny.com/congress/reference/cong_request_next.md)
to retrieve additional pages of results.

## Examples

``` r
if (FALSE) { # congress::has_congress_key()
# Requires API Key

cong_member()

cong_member(bioguide = 'L000174')

cong_member(bioguide = 'L000174', item = 'sponsored-legislation')

cong_member(congress = 118)

cong_member(congress = 118, state = 'CA')

cong_member(congress = 118, state = 'CA', district = 1)

cong_member(state = 'MI', district = 2)
}
```
