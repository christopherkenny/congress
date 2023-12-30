with_mock_dir("t/congress", {
  test_that("cong_congress works", {
    x <- cong_congress()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/congress1", {
  test_that("cong_congress with congress works", {
    x <- cong_congress(congress = 115)
    expect_s3_class(x, 'tbl_df')
  })
})

test_that("cong_congress errors with from_date missing to_date", {
  expect_error(cong_congress(from_date = '2023-05-05'))
})
