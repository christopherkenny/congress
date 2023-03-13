with_mock_dir("httptest2/h_comm", {
  test_that("cong_house_communication works", {
    x <- cong_house_communication()
    expect_s3_class(x, 'tbl_df')
  })
})
