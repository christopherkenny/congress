#' Request Committee Print Information
#'
#' @param congress Congress number to search for. 81 or later are supported.
#' @param chamber Chamber name. Can be `'house'`, `'senate'`, or `'nochamber'`.
#' @param number Jacket number for the print. Character (or numeric).
#' @param item Information to request. Can be  `'text'`.
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
#'
#' # Requires API Key
#'
#' cong_committee_print()
#'
#' cong_committee_print(congress = 118)
#'
#' cong_committee_print(chamber = 'house')
#'
#' cong_committee_print(congress = 118, chamber = 'house')
#'
#' cong_committee_print(congress = 117, chamber = 'house', number = '48144')
#'
#' cong_committee_print(congress = 117, chamber = 'house', number = '48144', item = 'text')
cong_committee_print <- function(congress = NULL, chamber = NULL, number = NULL, item = NULL,
                                 from_date = NULL, to_date = NULL,
                                   limit = 20, offset = 0,
                                   format = 'json', clean = TRUE) {
  sort <- NULL
  check_format(format)

  endpt <- committee_print_endpoint(congress = congress, chamber = chamber,
                                      number = number, item = item)
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key(),
      'fromDateTime' = from_date,
      'toDateTime' = to_date,
      'limit' = min(max(limit, 1), 250),
      'offset' = max(offset, 0)
    ) |>
    httr2::req_headers(
      "accept" = glue::glue("application/{format}")
    )

  out <- req |>
    httr2::req_perform()

  formatter <- switch(format,
                      'json' = httr2::resp_body_json,
                      'xml' = httr2::resp_body_xml
  )

  out <- out |>
    formatter()

  if (clean) {
    if (is.null(number)) {
      out <- out |>
        purrr::pluck('committeePrints') |>
        list_hoist() |>
        clean_names()
    } else {
      if (is.null(item)) {
        out <- out |>
          purrr::pluck('committeePrint') |>
          list_hoist() |>
          clean_names()
      } else {
        out <- out |>
          purrr::pluck(item) |>
          dplyr::bind_rows() |>
          clean_names()
      }
    }
  }
  out
}

committee_print_items <- c('text')

committee_print_endpoint <- function(congress, chamber, number, item) {
  out <- 'committee-print'
  if (!is.null(congress)) {
    out <- paste0(out, '/', congress)
    if (!is.null(chamber)) {
      out <- paste0(out, '/', chamber)
      if (!is.null(number)) {
        out <- paste0(out, '/', number)
      }
      if (!is.null(item)) {
        out <- paste0(out, '/', item)
      }
    }
  }

  tolower(out)
}
