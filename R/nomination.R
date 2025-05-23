#' Request Nomination Information
#'
#' @param congress Congress number to search for. 81 or later are supported.
#' @param number Nomination assigned number. Numeric.
#' @param item Information to request. Can be `'actions'`, `'committees'`, '`hearings'` or the ordinal number.
#' @param from_date start date for search, e.g. `'2022-04-01'`. Defaults to most recent.
#' @param to_date end date for search, e.g. `'2022-04-03'`. Defaults to most recent.
#' @param limit number of records to return. Default is 20. Will be truncated to between 1 and 250.
#' @param offset number of records to skip. Default is 0. Must be non-negative.
#' @param clean Default is TRUE. Should output be returned as a `tibble` (`TRUE`) or requested `format`.
#' @param format Output format for `clean = FALSE`. One of `xml` or `json`.
#'
#' @return `tibble` or HTTP response if `clean = FALSE`
#' @export
#'
#' @examplesIf congress::has_congress_key()
#' # Requires API Key
#'
#' cong_nomination()
#'
#' cong_nomination(congress = 118)
#'
#' cong_nomination(congress = 117, number = 2467)
#'
#' cong_nomination(congress = 117, number = 2467, item = 'actions')
#'
#' cong_nomination(congress = 117, number = 2467, item = 1)
#'
cong_nomination <- function(congress = NULL, number = NULL, item = NULL,
                            from_date = NULL, to_date = NULL,
                            limit = 20, offset = 0,
                            format = 'json', clean = TRUE) {
  sort <- NULL
  check_format(format)
  if (clean) {
    format <- 'json'
  }

  from_date <- check_date(from_date)
  to_date <- check_date(to_date)
  if (is.null(from_date) & !is.null(to_date) || !is.null(from_date) & is.null(to_date)) {
    cli::cli_abort('Either both or neither of {.arg from_date} and {.arg to_date} must be specified.')
  }

  endpt <- nomination_endpoint(congress = congress, number = number, item = item)
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key(),
      'fromDateTime' = from_date,
      'toDateTime' = to_date,
      'sort' = sort,
      'limit' = min(max(limit, 1), 250),
      'offset' = max(offset, 0)
    ) |>
    httr2::req_headers(
      'accept' = glue::glue('application/{format}')
    )
  resp <- req |>
    httr2::req_perform()

  formatter <- switch(format,
    'json' = httr2::resp_body_json,
    'xml' = httr2::resp_body_xml
  )

  out <- resp |>
    formatter()

  if (clean) {
    if (is.null(number)) {
      out <- out |>
        purrr::pluck('nominations') |>
        list_hoist() |>
        clean_names()
    } else {
      if (is.null(item)) {
        out <- out |>
          purrr::pluck('nomination') |>
          tibble::enframe() |>
          tidyr::pivot_wider() |>
          tidyr::unnest_wider(col = where(~ purrr::pluck_depth(.x) < 4), simplify = TRUE, names_sep = '_') |>
          dplyr::rename_with(.fn = function(x) stringr::str_sub(x, end = -3), .cols = dplyr::ends_with('_1')) |>
          clean_names()
      } else {
        out <- out |>
          purrr::pluck(item) |>
          dplyr::bind_rows() |>
          clean_names()
      }
    }
    out <- out |>
      add_resp_info(resp) |>
      cast_date_columns()
  }
  out
}

nomination_items <- c('actions', 'committees', 'hearings')

nomination_endpoint <- function(congress, number, item) {
  out <- 'nomination'
  if (!is.null(congress)) {
    out <- paste0(out, '/', congress)
    if (!is.null(number)) {
      out <- paste0(out, '/', number)
      if (!is.null(item)) {
        out <- paste0(out, '/', item)
      }
    }
  }

  tolower(out)
}
