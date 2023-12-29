with_mock_dir("httptest2/bndrcd", {
  test_that("cong_bound_record works", {
    x <- cong_bound_record()
    expect_s3_class(x, 'tbl_df')
  })
})
