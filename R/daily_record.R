#' Request daily Congressional Record Information
#'
#' @param volume Volume of the daily Congressional record. Character (or numeric).
#' @param issue Issue of the daily Congressional record. Character (or numeric).
#' @param item Information to request. Can be `'articles'`
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
#' cong_daily_record()
#'
#' cong_daily_record(volume = 166)
#'
#' cong_daily_record(volume = 168, issue = 153)
#'
#' cong_daily_record(volume = 167, issue = 21, item = 'articles')
#'
cong_daily_record <- function(volume = NULL, issue = NULL, item = NULL,
                        limit = 20, offset = 0,
                        format = 'json', clean = TRUE) {
  sort <- NULL
  check_format(format)

  endpt <- daily_record_endpoint(volume, issue, item)
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key(),
      'volumeNumber' = volume,
      'issueNumber' = issue,
      'sort' = sort,
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
    if (is.null(issue)) {
      out <- out |>
        purrr::pluck('dailyCongressionalRecord') |>
        dplyr::bind_rows() |>
        clean_names()
    } else {
      if (is.null(item)) {
        out <- out |>
          purrr::pluck('issue') |>
          tibble::enframe() |>
          tidyr::pivot_wider() |>
          tidyr::unnest_wider(col = where(~purrr::pluck_depth(.x) < 4), simplify = TRUE, names_sep = '_') |>
          dplyr::rename_with(.fn = function(x) stringr::str_sub(x, end = -3), .cols = dplyr::ends_with('_1')) |>
          dplyr::mutate(dplyr::across(dplyr::any_of('fullIssue'), function(x) lapply(x, dplyr::bind_rows))) |>
          clean_names()
      } else {
        out <- out |>
          purrr::pluck(item) |>
          lapply(function(x) tibble::tibble(name = x$name, sectionArticles = list(x$sectionArticles))) |>
          purrr::list_rbind() |>
          clean_names() |>
          dplyr::mutate(dplyr::across(where(is.list), function(x) {
            lapply(x, function(y) clean_names(dplyr::bind_rows(y)))
          }))
      }

    }
    out <- out |>
      add_resp_info(resp) |>
      cast_date_columns()
  }
  out
}


daily_record_endpoint <- function(volume, issue, item) {
  out <- 'daily-congressional-record'

  if (!is.null(volume)) {
    out <- paste0(out, '/', volume)
    if (!is.null(issue)) {
      out <- paste0(out, '/', issue)
      if (!is.null(item)) {
        out <- paste0(out, '/', item)
      }
    }
  }

  tolower(out)
}
