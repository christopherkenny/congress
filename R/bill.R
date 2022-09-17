cong_bill <- function(format = 'json', clean = TRUE) {
  check_format(format)
  out <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('bill') |>
    httr2::req_headers(
      "accept" = glue::glue("application/{format}"),
      'api_key' = get_congress_key()
    ) |>
    httr2::req_dry_run()

  out
}
