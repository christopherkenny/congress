#' Request bound Congressional Record Information
#'
#' @param year integer for year
#' @param month integer for month
#' @param day integer for day of month
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
#' cong_bound_record()
#'
#' cong_bound_record(year = 1990)
#'
#' cong_bound_record(year = 1990, month = 5)
#'
#' cong_bound_record(year = 1948, month = 5, day = 19)
#'
cong_bound_record <- function(year = NULL, month = NULL, day = NULL,
                              limit = 20, offset = 0,
                              format = 'json', clean = TRUE) {
  sort <- NULL
  check_format(format)
  if (clean) {
    format <- 'json'
  }

  endpt <- bound_record_endpoint(year, month, day)
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key(),
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
    out <- out |>
      purrr::pluck('boundCongressionalRecord') |>
      list_hoist() |>
      clean_names()
    out <- out |>
      add_resp_info(resp) |>
      cast_date_columns()
  }
  out
}


bound_record_endpoint <- function(year, month, day) {
  out <- 'bound-congressional-record'

  if (!is.null(year)) {
    out <- paste0(out, '/', year)
    if (!is.null(month)) {
      out <- paste0(out, '/', month)
      if (!is.null(day)) {
        out <- paste0(out, '/', day)
      }
    }
  }

  tolower(out)
}
