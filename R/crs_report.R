#' Request Congressional Research Service (CRS) Report Information
#'
#' @param crs_id Optional CRS identifier. If provided, returns a specific report.
#' @param from_date Start date for search, e.g. `'2022-01-01'`. Optional.
#' @param to_date End date for search, e.g. `'2022-01-31'`. Optional.
#' @param limit Number of records to return. Default is 20. Will be truncated to between 1 and 250.
#' @param offset Number of records to skip. Default is 0. Must be non-negative.
#' @param clean Should output be returned as a tibble (`TRUE`) or requested format (`FALSE`). Default is `TRUE`.
#' @param format Output format for `clean = FALSE`. One of `'json'` or `'xml'`.
#'
#' @return A `tibble::tibble` or raw HTTP response if `clean = FALSE`.
#' @export
#'
#' @examplesIf congress::has_congress_key()
#' # Requires API Key
#'
#' cong_crs_report()
#'
#' cong_crs_report(crs_id = '93-792')
cong_crs_report <- function(crs_id = NULL,
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

  endpt <- crs_report_endpoint(crs_id = crs_id)
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
  resp <- req |> httr2::req_perform()

  formatter <- switch(format,
    'json' = httr2::resp_body_json,
    'xml' = httr2::resp_body_xml
  )

  out <- resp |> formatter()

  if (clean) {
    if (is.null(crs_id)) {
      out <- out |>
        purrr::pluck('CRSReports') |>
        list_hoist() |>
        clean_names()
    } else {
      out <- out |>
        purrr::pluck('CRSReport') |>
        widen() |>
        clean_names()
    }

    out <- out |>
      add_resp_info(resp) |>
      cast_date_columns()
  }

  out
}

crs_report_endpoint <- function(crs_id = NULL) {
  out <- 'crsreport'
  if (!is.null(crs_id)) {
    out <- paste0(out, '/', crs_id)
  }
  tolower(out)
}
