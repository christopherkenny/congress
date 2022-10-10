with_mock_dir("httptest2/treaty", {
  test_that("cong_treaty works", {
    x <- cong_treaty()
    expect_s3_class(x, 'tbl_df')
  })
})
