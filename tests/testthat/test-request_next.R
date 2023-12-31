test_that("cong_request_next errors without arg", {
  expect_error(cong_request_next())
})

test_that("cong_request_next returns object if no pagination", {
  x <- cong_request_next(tibble::tibble())
  expect_s3_class(x, 'tbl_df')
})

with_mock_dir("t/reqnext", {
  test_that("cong_request_next works", {
    x <- tibble::tibble() |>
      `attr<-`('response_info', list('pagination' = list('next' = 'https://api.congress.gov/v3/bill/118?offset=20&limit=20&format=json'))) |>
        cong_request_next()
    expect_s3_class(x, 'tbl_df')
  })
})
