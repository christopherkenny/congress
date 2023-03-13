#' Request Communication Information
#'
#' `r lifecycle::badge('deprecated')`
#' Deprecated. Please use `cong_house_communication()`, as a friend, `cong_senate_communication()` has been added.
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
#' @return `tibble` or HTTP response if `clean = FALSE`
#' @export
#'
#' @examplesIf congress::has_congress_key()
#' # Requires API Key
#'
#' cong_communication()
#'
#' cong_communication(congress = 117)
#'
#' cong_communication(congress = 117, type = 'ec')
#'
#' cong_communication(congress = 117, type = 'ec', number = 3324)
#'
cong_communication <- function(congress = NULL, type = NULL, number = NULL,
                               from_date = NULL, to_date = NULL,
                               limit = 20, offset = 0,
                               format = 'json', clean = TRUE) {
  lifecycle::deprecate_soft(when = '0.0.2', what = 'cong_communication()', with = 'cong_house_communication()')
  cong_house_communication(
    congress, type, number,
    from_date, to_date,
    limit, offset,
    format, clean
  )
}

