#' Request Bill Information
#'
#' @param congress Congress number to search for. 81 or later are supported.
#' @param type Type of bill. Can be `'hr'`, `'s'`, `'hjres'`, `'sjres'`, `'hconres'`, `'sconres'`, `'hres'`, or `'sres'`.
#' @param number Bill assigned number. Numeric.
#' @param item Information to request. Can be `'actions'`, `'amendments'`, `'committees'`, `'cosponsors'`,
#' `'relatedbills'`, `'subjects'`, `'text'`, `'titles'`
#' @param clean Default is TRUE. Should output be returned as a `tibble` (`TRUE`) or requested `format`s.
#' @param format Output format for `clean = FALSE`. One of `xml` or `json`.
#'
#' @return `tibble` or HTTP response.
#' @export
#'
#' @examples
#' \dontrun{
#' # Requires API Key
#'
#' cong_bill()
#'
#' cong_bill(congress = 117)
#'
#' cong_bill(congress = 117, type = 'hr', number = 3076, clean = F)
#'
#'
#' }
#'
cong_bill <- function(congress = NULL, type = NULL, number = NULL, item = NULL,
                      format = 'json', clean = TRUE) {
  check_format(format)
  endpt <- bill_endpoint(congress = congress, type = type, number = number)
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key()
    ) |>
    httr2::req_headers(
      "accept" = glue::glue("application/{format}")
    )
  out <- req |>
    httr2::req_perform()

  if (clean) {
    formatter <- switch (format,
      'json' = httr2::resp_body_json,
      'xml' = httr2::resp_body_xml
    )
    out <- out |>
      formatter() |>
      purrr::pluck('bills') |>
      list_hoist() |>
      clean_names()
  }
  out
}

bill_items <- c('actions', 'amendments', 'committees', 'cosponsors', 'relatedbills', 'subjects', 'text', 'titles')
bill_types <- c('hr', 's', 'hjres', 'sjres', 'hconres', 'sconres', 'hres', 'sres')

bill_endpoint <- function(congress, type, number, item) {
  out <- 'bill'
  if (!is.null(congress)) {
    out <- paste0(out, '/', congress)
    if (!is.null(type)) {
      out <- paste0(out, '/', type)
      if (!is.null(number)) {
        out <- paste0(out, '/', number)
      }
    }
  }

  out
}
