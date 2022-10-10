with_mock_dir("httptest2/amendment", {
  test_that("cong_amendment works", {
    x <- cong_amendment()
    expect_s3_class(x, 'tbl_df')
  })
})


