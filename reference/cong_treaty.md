# Request Treaty Information

Request Treaty Information

## Usage

``` r
cong_treaty(
  congress = NULL,
  number = NULL,
  suffix = NULL,
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

- number:

  Treaty assigned number. Numeric.

- suffix:

  Treaty partition letter value. Character.

- item:

  Information to request. Can be `'actions'`, or `'committees'`.

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

## See also

[`cong_request_next()`](http://christophertkenny.com/congress/reference/cong_request_next.md)
to retrieve additional pages of results.

## Examples

``` r
if (FALSE) { # congress::has_congress_key()

# Requires API Key

cong_treaty()

cong_treaty(congress = 117)

cong_treaty(congress = 117, number = 3)

cong_treaty(congress = 114, number = 13, suffix = 'A')

cong_treaty(congress = 117, number = 3, item = 'actions')

cong_treaty(congress = 114, number = 13, suffix = 'A', item = 'actions')
}
```
