# Request House Requirement data

Request House Requirement data

## Usage

``` r
cong_house_requirement(
  number = NULL,
  item = NULL,
  limit = 20,
  offset = 0,
  format = "json",
  clean = TRUE
)
```

## Arguments

- number:

  Requirement's assigned number. Numeric.

- item:

  Information to request. Can be `'matching-communications'`.

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

cong_house_requirement()

cong_house_requirement(number = 12478)

cong_house_requirement(number = 8070, 'matching-communications')
}
```
