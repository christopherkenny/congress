# devtools ----
# devtools not intended for use in production, not tested
lrj <- function() { # nocov start
  httr2::last_response() |>
    httr2::resp_body_json()
} # nocov end

.gl <- function(x) { # nocov start
  dplyr::glimpse(x)
} # nocov end

# formatting utils ----
list_hoist <- function(l) {
  dplyr::bind_rows(lapply(l, function(x) dplyr::bind_rows(unlist(x))))
}

clean_names <- function(x) {
  out <- names(x) |>
    stringr::str_replace_all('\\.', '_') |>
    stringr::str_replace_all('([a-z])([A-Z])', '\\1_\\2') |>
    stringr::str_to_lower() |>
    stringr::str_remove_all('$')
  stats::setNames(object = x, nm = out)
}

str_colname <- function(x) {
  x |>
    stringr::str_replace_all(' ', '_') |>
    stringr::str_to_lower()
}

# req info utils ----
add_resp_info <- function(tb, l) {
  l_sub <- purrr::keep_at(l, at = c('pagination', 'request'))
  `attr<-`(tb, 'response_info', l_sub)
}

all_nchar_10 <- function(x) {
  all(nchar(stats::na.omit(x)) == 10)
}
all_nchar_20 <- function(x) {
  all(nchar(stats::na.omit(x)) == 20)
}

cast_date_columns <- function(tb) {
  tb |>
    dplyr::mutate(
      dplyr::across(dplyr::contains('date') & where(all_nchar_10), function(x) as.Date(x, format = '%Y-%m-%d')),
      dplyr::across(dplyr::contains('date') & where(all_nchar_20),
                    function(x) as.POSIXct(x, format = '%Y-%m-%dT%H:%M:%SZ', tz = 'UTC'))
    )
}
