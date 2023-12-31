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

# request next ----
parse_fun_from_url <- function(x) {
  endpt <- x |>
    httr2::url_parse() |>
    purrr::pluck('path') |>
    stringr::str_split('/') |>
    unlist() |>
    purrr::pluck(3) # 1 = '', 2 = 'v3, 3 = endpoint

  rlang::as_closure(do.call(switch, args = c(endpt, endpoints)))
}

parse_args <- function(x, fn) {
  components <- x |>
    httr2::url_parse()

  url_pieces <- components |>
    purrr::pluck('path') |>
    stringr::str_split('/') |>
    unlist() |>
    purrr::discard_at(at = 1:3)
  names(url_pieces) <- names(formals(fn))[seq_along(url_pieces)]

  query <- unlist(components$query)
  names(query) <- names(query) |>
    stringr::str_replace(pattern = 'fromDateTime', replacement = 'from_date') |>
    stringr::str_replace(pattern = 'toDateTime', replacement = 'to_date')

  c(url_pieces, query)
}

endpoints <- list(
  'amendment' = 'cong_amendment',
  'bill' = 'cong_bill',
  'bound-congressional-record' = 'cong_bound_record',
  'committee-meeting' = 'cong_committee_meeting',
  'committee-print' = 'cong_committee_print',
  'committee-report' = 'cong_committee_report',
  'committee' = 'cong_committee',
  'congress' = 'cong_congress',
  'daily-congressional-record' = 'cong_daily_record',
  'house-communication' = 'cong_house_communication',
  'house-requirement' = 'cong_house_requirement',
  'member' = 'cong_member',
  'nomination' = 'cong_nomination',
  'congressional-record' = 'cong_record',
  'senate-communication' = 'cong_senate_communication',
  'summaries' = 'cong_summaries',
  'treaty' = 'cong_treaty'
)
