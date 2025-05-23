#' Request Member Information
#'
#' This provides three search paths under the `/member` endpoint.
#' 1. By `bioguide`, which can be subset with `item`
#' 2. By `congress`, which can be subset with `state` and `district`
#' 3. By `state`, which can be subset with `district`
#'
#' If an invalid set of these are provided, they will be used in the above order.
#'
#' @param bioguide Bioguide identifier for a member of Congress.
#' @param item Information to request. Can be `'sponsored-legislation'` or  `'cosponsored-legislation'`
#' @param congress Congress number.
#' @param state State abbreviation. e.g. `'CA'`.
#' @param district Congressional district number. e.g. `1`.
#' @param current_member Logical. Should only current members be returned? Default is `FALSE`.
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
#' @examplesIf congress::has_congress_key()
#' # Requires API Key
#'
#' cong_member()
#'
#' cong_member(bioguide = 'L000174')
#'
#' cong_member(bioguide = 'L000174', item = 'sponsored-legislation')
#'
#' cong_member(congress = 118)
#'
#' cong_member(congress = 118, state = 'CA')
#'
#' cong_member(congress = 118, state = 'CA', district = 1)
#'
#' cong_member(state = 'MI', district = 2)
#'
cong_member <- function(bioguide = NULL, item = NULL,
                        congress = NULL,
                        state = NULL, district = NULL,
                        current_member = FALSE,
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

  endpt <- member_endpoint(bioguide = bioguide, item = item,
                           congress = congress, state = state, district = district)
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key(),
      'fromDateTime' = from_date,
      'toDateTime' = to_date,
      'sort' = sort,
      'limit' = min(max(limit, 1), 250),
      'offset' = max(offset, 0),
      'currentMember' = current_member
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
    if (is.null(bioguide)) {
      out <- out |>
        purrr::pluck('members') |>
        lapply(purrr::list_flatten) |>
        dplyr::bind_rows() |>
        clean_names()
    } else {
      if (is.null(item)) {
        out <- out |>
          purrr::pluck('member') |>
          tibble::enframe() |>
          tidyr::pivot_wider() |>
          tidyr::unnest_wider(col = where(~ purrr::pluck_depth(.x) < 4), simplify = TRUE, names_sep = '_') |>
          dplyr::rename_with(.fn = function(x) stringr::str_sub(x, end = -3), .cols = dplyr::ends_with('_1')) |>
          clean_names() #|>
        # dplyr::mutate(across(where(is.list), function(x) lapply(x, dplyr::bind_rows)))
      } else {
        item <- item |>
          stringr::str_replace_all('-([a-z])', toupper) |>
          stringr::str_remove_all('-')

        out <- out |>
          purrr::pluck(item) |>
          list_hoist() |>
          clean_names()
      }
    }
    out <- out |>
      add_resp_info(resp) |>
      cast_date_columns()
  }
  out
}

member_items <- c('sponsored-legislation', 'cosponsored-legislation')

member_endpoint <- function(bioguide, item, congress, state, district) {
  out <- 'member'
  if (!is.null(bioguide)) {
    out <- paste0(out, '/', bioguide)
    if (!is.null(item)) {
      out <- paste0(out, '/', item)
    }
  } else if (!is.null(congress)) {
    out <- paste0(out, '/congress/', congress)
    if (!is.null(state)) {
      out <- paste0(out, '/', state)
      if (!is.null(district)) {
        out <- paste0(out, '/', district)
      }
    }
  } else if (!is.null(state)) {
    out <- paste0(out, '/', state)
    if (!is.null(district)) {
      out <- paste0(out, '/', district)
    }
  }

  tolower(out)
}
