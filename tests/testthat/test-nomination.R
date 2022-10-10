with_mock_dir("httptest2/nomination", {
  test_that("cong_nomination works", {
    x <- cong_nomination()
    expect_s3_class(x, 'tbl_df')
  })
})
