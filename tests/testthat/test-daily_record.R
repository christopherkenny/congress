with_mock_dir("httptest2/dairec", {
  test_that("cong_daily_record works", {
    x <- cong_daily_record()
    expect_s3_class(x, 'tbl_df')
  })
})
