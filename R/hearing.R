#' Request Hearing Information
#'
#' @param congress Congress number to search for. 81 or later are supported.
#' @param chamber Chamber name. Can be `'house'`, `'senate'`, or `'nochamber'`.
#' @param number Jacket number for the hearing. Character (or numeric).
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
#' cong_hearing()
#'
#' cong_hearing(congress = 116)
#'
#' cong_hearing(chamber = 'house')
#'
#' cong_hearing(congress = 116, chamber = 'house')
#'
#' cong_hearing(congress = 116, chamber = 'house', number = 41365)
cong_hearing <- function(congress = NULL, chamber = NULL, number = NULL,
                         limit = 20, offset = 0,
                         format = 'json', clean = TRUE) {
  sort <- NULL
  check_format(format)
  if (clean) {
    format <- 'json'
  }

  endpt <- hearing_endpoint(congress = congress, chamber = chamber,
                            number = number)
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key(),
      # 'fromDateTime' = from_date,
      # 'toDateTime' = to_date,
      # 'sort' = sort,
      'limit' = min(max(limit, 1), 250),
      'offset' = max(offset, 0)
    ) |>
    httr2::req_headers(
      "accept" = glue::glue("application/{format}")
    )
  resp <- req |>
    httr2::req_perform()

  formatter <- switch(format,
                      'json' = httr2::resp_body_json,
                      'xml' = httr2::resp_body_xml
  )

  out <- resp <- resp |>
    formatter()

  if (clean) {
    if (is.null(number)) {
      out <- out |>
        purrr::pluck('hearings') |>
        list_hoist() |>
        clean_names()
    } else {
      out <- out |>
        purrr::pluck('hearing') |>
        tibble::enframe() |>
        tidyr::pivot_wider() |>
        tidyr::unnest_wider(col = where(~purrr::pluck_depth(.x) < 4), simplify = TRUE, names_sep = '_') |>
        tidyr::unnest_wider('committees', names_sep = '_') |>
        tidyr::unnest_wider('committees_1') |>
        dplyr::rename_with(.fn = function(x) stringr::str_sub(x, end = -3), .cols = dplyr::ends_with('_1')) |>
        clean_names()
    }
    out <- out |>
      add_resp_info(resp) |>
      cast_date_columns()
  }
  out
}

hearing_endpoint <- function(congress, chamber, number) {
  out <- 'hearing'
  if (!is.null(congress)) {
    out <- paste0(out, '/', congress)
    if (!is.null(chamber)) {
      out <- paste0(out, '/', chamber)
      if (!is.null(number)) {
        out <- paste0(out, '/', number)
      }
    }
  }

  tolower(out)
}
