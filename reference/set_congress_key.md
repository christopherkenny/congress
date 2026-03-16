# Add Entry to Renviron

Adds Congress API key to .Renviron.

## Usage

``` r
set_congress_key(key, overwrite = FALSE, install = FALSE)
```

## Arguments

- key:

  Character. API key to add to add.

- overwrite:

  Defaults to FALSE. Boolean. Should existing `CONGRESS_KEY` in Renviron
  be overwritten?

- install:

  Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?

## Value

key, invisibly

## Examples

``` r
if (FALSE) { # \dontrun{
set_congress_key('1234')
} # }
```
