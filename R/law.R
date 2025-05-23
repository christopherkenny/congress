#' Request Law Information
#'
#' @param congress Congress number to search for. 81 or later are supported.
#' @param type Type of law. Must be 'pub' or 'priv'.
#' @param number Law number. Numeric.
#' @param from_date Start date for search, e.g. '2022-04-01'. Optional.
#' @param to_date End date for search, e.g. '2022-04-30'. Optional.
#' @param limit Number of records to return. Default is 20. Will be truncated to between 1 and 250.
#' @param offset Number of records to skip. Default is 0. Must be non-negative.
#' @param clean Should output be returned as a tibble (TRUE) or requested format (FALSE). Default is TRUE.
#' @param format Output format for clean = FALSE. One of 'json' or 'xml'.
#'
#' @return A tibble or raw HTTP response if clean = FALSE.
#' @export
#'
#' @examplesIf congress::has_congress_key()
#' # Requires API Key
#'
#' cong_law(congress = 118)
#'
#' cong_law(congress = 118, type = 'pub')
#'
#' cong_law(congress = 118, type = 'pub', number = 108)
cong_law <- function(congress = 118, type = NULL, number = NULL,
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

  endpt <- law_endpoint(congress = congress, type = type, number = number)
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
    if (is.null(number)) {
      out <- out |>
        purrr::pluck('bills') |>
        list_hoist() |>
        clean_names()
    } else {
      out <- out |>
        purrr::pluck('bill') |>
        widen() |>
        clean_names()
    }

    out <- out |>
      add_resp_info(resp) |>
      cast_date_columns()
  }

  out
}

law_endpoint <- function(congress = NULL, type = NULL, number = NULL) {
  out <- 'law'
  if (!is.null(congress)) {
    out <- paste0(out, '/', congress)
    if (!is.null(type)) {
      out <- paste0(out, '/', type)
      if (!is.null(number)) {
        out <- paste0(out, '/', number)
      }
    }
  }

  tolower(out)
}
