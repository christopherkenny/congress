list_hoist <- function(l) {
  dplyr::bind_rows(lapply(l, function(x) dplyr::bind_rows(unlist(x))))
}

clean_names <- function(x) {
  out <-names(x) |>
    stringr::str_replace_all('\\.', '_') |>
    stringr::str_replace_all('([a-z])([A-Z])', '\\1_\\2') |>
    stringr::str_to_lower()
  stats::setNames(object = x, nm = out)
}
