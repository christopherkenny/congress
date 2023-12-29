#' Request Congressional Record Information
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
#' cong_record()
#'
#' cong_record(year = 2022, month = 6, day = 28)
#'
cong_record <- function(year = NULL, month = NULL, day = NULL,
                        limit = 20, offset = 0,
                        format = 'json', clean = TRUE) {
  sort <- NULL
  check_format(format)

  endpt <- record_endpoint()
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key(),
      'y' = year,
      'm' = month,
      'd' = day,
      'sort' = sort,
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
    out <- out |>
      purrr::pluck('Results') |>
      tibble::enframe() |>
      tidyr::pivot_wider() |>
      tidyr::unnest_wider(col = where(~purrr::pluck_depth(.x) < 4), simplify = TRUE, names_sep = '_') |>
      dplyr::rename_with(.fn = function(x) stringr::str_sub(x, end = -3), .cols = dplyr::ends_with('_1')) |>
      clean_names()
  }
  out
}


record_endpoint <- function() {
  out <- 'congressional-record'

  tolower(out)
}
