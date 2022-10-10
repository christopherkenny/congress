with_mock_dir("httptest2/congress", {
  test_that("cong_congress works", {
    x <- cong_congress()
    expect_s3_class(x, 'tbl_df')
  })
})
