#' Request House Communication Information
#'
#' @param congress Congress number to search for. 81 or later are supported.
#' @param type Type of communication. Can be `'ec'`, `'ml'`, `'pm'`, or `'pt'`.
#' @param number Communication assigned number. Numeric.
#' @param from_date start date for search, e.g. `'2022-04-01'`. Defaults to most recent.
#' @param to_date end date for search, e.g. `'2022-04-03'`. Defaults to most recent.
#' @param limit number of records to return. Default is 20. Will be truncated to between 1 and 250.
#' @param offset number of records to skip. Default is 0. Must be non-negative.
#' @param clean Default is TRUE. Should output be returned as a `tibble` (`TRUE`) or requested `format`.
#' @param format Output format for `clean = FALSE`. One of `xml` or `json`.
#'
#' @return a `tibble::tibble` or HTTP response if `clean = FALSE`
#' @export
#'
#' @examplesIf congress::has_congress_key()
#' # Requires API Key
#'
#' cong_house_communication()
#'
#' cong_house_communication(congress = 117)
#'
#' cong_house_communication(congress = 117, type = 'ec')
#'
#' cong_house_communication(congress = 117, type = 'ec', number = 3324)
#'
cong_house_communication <- function(congress = NULL, type = NULL, number = NULL,
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

  endpt <- house_communication_endpoint(congress = congress, type = type, number = number)
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
        purrr::pluck('houseCommunications') |>
        list_hoist() |>
        clean_names()
    } else {
      out <- out |>
        purrr::pluck('houseCommunication') |>
        widen() |>
        clean_names()
    }
    out <- out |>
      add_resp_info(resp) |>
      cast_date_columns()
  }
  out
}

house_communication_types <- c('ec', 'ml', 'pm', 'pt')

house_communication_endpoint <- function(congress, type, number) {
  out <- 'house-communication'
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
