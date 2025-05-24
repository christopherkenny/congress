#' Request House Roll Call Vote Information
#'
#' @param congress Congress number to search for. Numeric.
#' @param session Session number (`1` or `2`). Numeric.
#' @param number Roll call vote number. Numeric.
#' @param item Information to request. Can be `'members'`.
#' @param from_date start date for search, e.g. `'2022-04-01'`. Defaults to most recent.
#' @param to_date end date for search, e.g. `'2022-04-03'`. Defaults to most recent.
#' @param limit number of records to return. Default is 20. Will be truncated to between 1 and 250.
#' @param offset number of records to skip. Default is 0. Must be non-negative.
#' @param clean Default is `TRUE`. Should output be returned as a `tibble` (`TRUE`) or requested `format`.
#' @param format Output format for `clean = FALSE`. One of `xml` or `json`.
#'
#' @return A tibble or raw HTTP response if clean = FALSE.
#' @export
#'
#' @examplesIf congress::has_congress_key()
#'
#' cong_house_vote()
#'
#' cong_house_vote(congress = 119, session = 1, number = 17)
#'
#' cong_house_vote(congress = 119, session = 1, number = 17, item = 'members')
cong_house_vote <- function(congress = NULL, session = NULL, number = NULL,
                            item = NULL,
                            from_date = NULL, to_date = NULL,
                            limit = 20, offset = 0,
                            format = 'json', clean = TRUE) {
  check_format(format)
  if (clean) format <- 'json'

  from_date <- check_date(from_date)
  to_date <- check_date(to_date)
  if (is.null(from_date) & !is.null(to_date) || !is.null(from_date) & is.null(to_date)) {
    cli::cli_abort('Either both or neither of {.arg from_date} and {.arg to_date} must be specified.')
  }

  endpt <- house_vote_endpoint(congress = congress, session = session, number = number, item = item)
  req <- httr2::request(api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key(),
      'fromDateTime' = from_date,
      'toDateTime' = to_date,
      'limit' = min(max(limit, 1), 250),
      'offset' = max(offset, 0)
    ) |>
    httr2::req_headers('accept' = glue::glue('application/{format}'))
  resp <- req |>
    httr2::req_perform()

  formatter <- switch(format,
                      'json' = httr2::resp_body_json,
                      'xml' = httr2::resp_body_xml
  )

  out <- resp |>
    formatter()

  if (clean) {
    if (is.null(session) || is.null(number)) {
      out <- out |>
        purrr::pluck('houseRollCallVotes') |>
        list_hoist() |>
        clean_names()
    } else {
      if (is.null(item)) {
        out <- out |>
          purrr::pluck('houseRollCallVote') |>
          widen() |>
          clean_names()
      } else {
        if (item == 'members') {
            out <- out |>
              purrr::pluck('houseRollCallVoteMemberVotes') |>
              widen() |>
              tidyr::unnest_longer(col = 'results') |>
              tidyr::unnest_wider('results', names_sep = '_') |>
              clean_names()
        }
      }
    }
    out <- out |>
      add_resp_info(resp) #|>
      #cast_date_columns()
  }

  out
}

house_vote_items <- c()
house_vote_types <- c()

house_vote_endpoint <- function(congress, session, number, item) {
  out <- 'house-vote'
  if (!is.null(congress)) {
    out <- paste0(out, '/', congress)
    if (!is.null(session)) {
      out <- paste0(out, '/', session)
      if (!is.null(number)) {
        out <- paste0(out, '/', number)
        if (!is.null(item)) {
          out <- paste0(out, '/', item)
        }
      }
    }
  }

  tolower(out)
}
