#' Request Committee Report Information
#'
#' @param congress Congress number to search for. 81 or later are supported.
#' @param type Type of committee report. Can be `'hrpt'`, `'srpt'`, or `'erpt'`.
#' @param number Committee report assigned number. Numeric.
#' @param item Information to request. Can be  `'text'`.
#' @param conference Filter to conference reports. Default is `FALSE`.
#' @param limit number of records to return. Default is 20. Will be truncated to between 1 and 250.
#' @param offset number of records to skip. Default is 0. Must be non-negative.
#' @param clean Default is TRUE. Should output be returned as a `tibble` if `clean = TRUE` or requested `format`.
#' @param format Output format for `clean = FALSE`. One of `xml` or `json`.
#'
#' @return `tibble` or HTTP response if `clean = FALSE`
#' @export
#'
#' @examplesIf congress::has_congress_key()
#'
#' # Requires API Key
#'
#' cong_committee_report()
#'
#' cong_committee_report(conference = TRUE)
#'
#' cong_committee_report(congress = 116)
#'
#' cong_committee_report(congress = 116, type = 'hrpt')
#'
#' cong_committee_report(congress = 116, type = 'hrpt', number = 617)
#'
cong_committee_report <- function(congress = NULL, type = NULL, number = NULL, item = NULL,
                                  conference = FALSE,
                                  limit = 20, offset = 0,
                                  format = 'json', clean = TRUE) {
  sort <- NULL
  check_format(format)

  endpt <- committee_report_endpoint(congress = congress, type = type, number = number, item = item)
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key(),
      # fromDateTime' = from_date,
      # toDateTime' = to_date,
      # sort' = sort,
      'conference' = tolower(as.character(conference)),
      'limit' = min(max(limit, 1), 250),
      'offset' = max(offset, 0)
    ) |>
    httr2::req_headers(
      'accept' = glue::glue('application/{format}')
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
        purrr::pluck('reports') |>
        list_hoist() |>
        clean_names()
    } else {
      if (is.null(item)) {
        out <- out |>
          purrr::pluck('committeeReports') |>
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

committee_report_items <- c('text')
committee_report_types <- c('hrpt', 'srpt', 'erpt')

committee_report_endpoint <- function(congress, type, number, item) {
  out <- 'committee-report'
  if (!is.null(congress)) {
    out <- paste0(out, '/', congress)
    if (!is.null(type)) {
      out <- paste0(out, '/', type)
      if (!is.null(number)) {
        out <- paste0(out, '/', number)
        if (!is.null(item)) {
          out <- paste0(out, '/', item)
        }
      }
    }
  }

  out
}
