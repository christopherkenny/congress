with_mock_dir("httptest2/record", {
  test_that("cong_record works", {
    x <- cong_record()
    expect_s3_class(x, 'tbl_df')
  })
})
