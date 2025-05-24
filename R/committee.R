#' Request Committee Information
#'
#' @param congress Congress number to search for. 81 or later are supported.
#' @param chamber Chamber name. Can be `'house'`, `'senate'`, or `'joint'`.
#' @param committee Code identifying committee. Character.
#' @param item Information to request. Can be `'bills'`, `'reports'`, `'nominations'`,
#' `'house-communication'`, or `'senate-communication'`.
#' @param from_date start date for search, e.g. `'2022-04-01'`. Defaults to most recent.
#' @param to_date end date for search, e.g. `'2022-04-03'`. Defaults to most recent.
#' @param limit number of records to return. Default is 20. Will be truncated to between 1 and 250.
#' @param offset number of records to skip. Default is 0. Must be non-negative.
#' @param clean Default is `TRUE`. Should output be returned as a `tibble` (`TRUE`) or requested `format`.
#' @param format Output format for `clean = FALSE`. One of `xml` or `json`.
#'
#' @return a `tibble::tibble` or HTTP response if `clean = FALSE`
#' @export
#'
#' @examplesIf congress::has_congress_key()
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
#' cong_committee(chamber = 'house', committee = 'hsed10')
#'
#' cong_committee(chamber = 'house', committee = 'hspw00', item = 'house-communication')
#'
#' cong_committee(chamber = 'senate', committee = 'jsec03')
#'
#' cong_committee(chamber = 'senate', committee = 'slpo00', item = 'bills')
#'
#' cong_committee(chamber = 'senate', committee = 'slpo00', item = 'senate-communication')
#'
cong_committee <- function(congress = NULL, chamber = NULL, committee = NULL, item = NULL,
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
    if (is.null(committee)) {
      out <- out |>
        purrr::pluck('committees') |>
        lapply(widen) |>
        purrr::list_rbind() |>
        clean_names()
    } else {
      if (is.null(item)) {
        out <- out |>
          purrr::pluck('committee') |>
          widen() |>
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
        } else if (item == 'house-communication') {
          out <- out |>
            purrr::pluck('houseCommunications') |>
            list_hoist() |>
            clean_names()
        } else if (item == 'senate-communication') {
          out <- out |>
            purrr::pluck('senateCommunications') |>
            list_hoist() |>
            clean_names()
        } else {
          singles <- out |>
            purrr::pluck('committee-bills') |>
            purrr::discard_at('bills') |>
            widen() |>
            dplyr::rename_with(.fn = function(x) paste0('committee_bill_', x))
          out <- out |>
            purrr::pluck('committee-bills', 'bills') |>
            lapply(widen) |>
            purrr::list_rbind() |>
            clean_names()
          out <- dplyr::bind_cols(singles, out)
        }
      }
    }
    out <- out |>
      add_resp_info(resp) |>
      cast_date_columns()
  }
  out
}

committee_chambers <- c('house', 'senate', 'joint')
committee_items <- c(
  'bills', 'reports', 'nominations', 'house-communication',
  'senate-communication'
)

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

  tolower(out)
}
