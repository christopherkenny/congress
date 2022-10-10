function(resp) {
  resp |>
    httptest2::gsub_response(pattern = congress::get_congress_key(), '123')
}
