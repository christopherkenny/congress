with_mock_dir("httptest2/communication", {
  test_that("cong_communication works", {
    x <- cong_communication()
    expect_s3_class(x, 'tbl_df')
  })
})
