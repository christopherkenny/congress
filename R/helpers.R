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

widen <- function(x, i = 4) {
  x |>
    tibble::enframe() |>
    tidyr::pivot_wider() |>
    tidyr::unnest_wider(col = where(~ purrr::pluck_depth(.x) < i), simplify = TRUE, names_sep = '_') |>
    dplyr::rename_with(.fn = function(x) substr(x, start = 1, stop = nchar(x) - 2), .cols = dplyr::ends_with('_1')) |>
    clean_names()
}

# list_to_row <- function(l) {
#   l |>
#     lapply(function(x) {
#       lapply(x, function(y) {
#         if (length(y) != 1) {
#           list(widen(y))
#         } else {
#           y
#         }
#       }) |>
#         tibble::as_tibble_row()
#     })
# }

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
all_nchar_25 <- function(x) {
  all(nchar(stats::na.omit(x)) == 25)
}

cast_date_columns <- function(tb) {
  tb |>
    dplyr::mutate(
      dplyr::across(dplyr::contains('date') & where(all_nchar_10), function(x) as.Date(x, format = '%Y-%m-%d')),
      dplyr::across(
        dplyr::contains('date') & where(all_nchar_20),
        function(x) as.POSIXct(x, format = '%Y-%m-%dT%H:%M:%SZ', tz = 'UTC')
      ),
      dplyr::across(
        dplyr::contains('date') & where(all_nchar_25),
        function(x) {
          if (any(stringr::str_detect(x, 'T'))) {
            as.POSIXct(x, tz = 'UTC')
          } else {
            as.POSIXct(
              stringr::str_replace(x, '(\\+|\\-)(\\d{2}):(\\d{2})', '\\1\\2\\3'),
              format = '%Y-%m-%d %H:%M:%S%z', tz = 'UTC'
            )
          }

        }
      )
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
