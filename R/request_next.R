#' Request next set of responses
#'
#' @param response A [tibble::tibble] from a `cong_*` function
#' @param max_req A max number of additional requests to make. Default is 1.
#'
#' @return a tibble with responses bound by row to new results
#' @export
#'
#' @examplesIf congress::has_congress_key()
#' # Requires API Key
#'
#' cong_bill() |>
#'   cong_request_next()
cong_request_next <- function(response, max_req = 1) {
  if (missing(response)) {
    cli::cli_abort('{.fn cong_request_next} must be called with an input to {.arg response}.')
  }

  resp_info <- attr(response, 'response_info')

  if (is.null(resp_info$pagination$`next`)) {
    return(response)
  }

  fn <- parse_fun_from_url(resp_info$pagination$`next`)
  fn_args <- parse_args(resp_info$pagination$`next`, fn)
  attr(response, 'response_info') <- NULL

  for (i in seq_len(max_req)) {
    new_resp <- rlang::inject(fn(!!!fn_args))
    response <- dplyr::bind_rows(
      response,
      new_resp
    ) |>
      `attr<-`('response_info', attr(new_resp, 'response_info'))

    resp_info <- attr(response, 'response_info')
    if (is.null(resp_info$pagination$`next`)) {
      return(response) # nocov
    }
    fn_args <- parse_args(resp_info$pagination$`next`, fn)
  }

  response
}
