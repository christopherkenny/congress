with_mock_dir("httptest2/hearing", {
  test_that("cong_hearing works", {
    x <- cong_hearing()
    expect_s3_class(x, 'tbl_df')
  })
})
