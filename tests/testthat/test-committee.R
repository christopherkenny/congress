with_mock_dir("httptest2/committee", {
  test_that("cong_committee works", {
    x <- cong_committee()
    expect_s3_class(x, 'tbl_df')
  })
})
