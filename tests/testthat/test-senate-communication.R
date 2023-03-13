with_mock_dir("httptest2/s_comm", {
  test_that("cong_senate_communication works", {
    x <- cong_senate_communication()
    expect_s3_class(x, 'tbl_df')
  })
})
