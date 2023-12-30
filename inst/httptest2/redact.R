function(resp) {
  resp |>
    # shorten url
    httptest2::gsub_response(pattern = 'api.congress.gov/', '') |>
    # redact key
    httptest2::gsub_response(pattern = congress::get_congress_key(), '')
}
