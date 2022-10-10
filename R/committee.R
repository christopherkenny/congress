#' Request Committee Information
#'
#' @param congress Congress number to search for. 81 or later are supported.
#' @param chamber Chamber name. Can be `'house'`, `'senate'`, or `'joint'`.
#' @param committee Code identifying committee. Character.
#' @param item Information to request. Can be `'bills'`, `'reports'`, or `'nominations'`.
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
#' @examples
#' \dontrun{
#' # Requires API Key
#'
#' cong_committee()
#'
#' cong_committee(congress = 117)
#'
#' cong_committee(chamber = 'house')
#'
#' cong_committee(congress = 117, chamber = 'house')
#'
#' cong_committee(chamber = 'house', committee = 'hspw00')
#'
#' cong_committee(chamber = 'senate', committee = 'ssas00', item = 'bills')
#'
#' }
#'
cong_committee <- function(congress = NULL, chamber = NULL, committee = NULL, item = NULL,
                      from_date = NULL, to_date = NULL,
                      limit = 20, offset = 0,
                      format = 'json', clean = TRUE) {
  sort <- NULL
  check_format(format)
  from_date <- check_date(from_date)
  to_date <- check_date(to_date)
  if (is.null(from_date) & !is.null(to_date) || !is.null(from_date) & is.null(to_date)) {
    cli::cli_abort('Either both or neither of {.arg from_date} and {.arg to_date} must be specified.')
  }

  endpt <- committee_endpoint(congress = congress, committee = committee, chamber = chamber, item = item)
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
    if (is.null(committee)) {
      out <- out |>
        purrr::pluck('committees') |>
        tibble::tibble(x = _) |>
        tidyr::unnest_wider(.data$x) |>
        clean_names()
    } else {
      if (is.null(item)) {
        out <- out |>
          purrr::pluck('committee') |>
          tibble::enframe() |>
          tidyr::pivot_wider() |>
          tidyr::unnest_wider(col = where(~purrr::vec_depth(.x) < 4), simplify = TRUE, names_sep = '_') |>
          dplyr::rename_with(.fn = function(x) stringr::str_sub(x, end = -3), .cols = dplyr::ends_with('_1')) |>
          clean_names()
      } else {
        if (item == 'reports') {
          out <- out |>
            purrr::pluck(item) |>
            dplyr::bind_rows() |>
            clean_names()
        } else if (item == 'nominations') {
          out <- out |>
            purrr::pluck(item) |>
            list_hoist() |>
            clean_names()
        } else {
          out <- out |>
            purrr::pluck('committee-bills') |>
            tibble::enframe() |>
            tidyr::pivot_wider() |>
            tidyr::unnest_wider(col = where(~purrr::vec_depth(.x) < 4), simplify = TRUE, names_sep = '_') |>
            tidyr::unnest_longer(.data$bills) |>
            tidyr::unnest_wider(.data$bills) |>
            clean_names()
        }

      }
    }
  }
  out
}

committee_chambers <- c('house', 'senate', 'joint')
committee_items <- c('bills', 'reports', 'nominations')

committee_endpoint <- function(congress, committee, chamber, item) {
  out <- 'committee'
  if (!is.null(congress)) {
    out <- paste0(out, '/', congress)
    if (!is.null(chamber)) {
      out <- paste0(out, '/', chamber)
    }
  } else {
    if (!is.null(chamber)) {
      out <- paste0(out, '/', chamber)
      if (!is.null(committee)) {
        out <- paste0(out, '/', committee)
        if (!is.null(item)) {
          out <- paste0(out, '/', item)
        }
      }
    }
  }

  out
}
