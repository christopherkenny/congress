cong_bill <- function(congress = NULL, format = 'json', clean = TRUE) {
  check_format(format)
  endpt <- endpt(type = 'bill', congress = congress)
  out <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append(endpt) |>
    httr2::req_url_query(
      'api_key' = get_congress_key()
    ) |>
    httr2::req_headers(
      "accept" = glue::glue("application/{format}")
    ) |>
    httr2::req_perform()

  if (clean) {
    out <- out |>
      httr2::resp_body_json() |>
      purrr::pluck('bills') |>
      list_hoist() |>
      clean_names()
  }
  out
}
