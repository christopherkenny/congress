with_mock_dir("httptest2/bill", {
  test_that("cong_bill works", {
    x <- cong_bill()
    expect_s3_class(x, 'tbl_df')
  })
})
