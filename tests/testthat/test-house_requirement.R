with_mock_dir("httptest2/h_req", {
  test_that("cong_house_requirement works", {
    x <- cong_house_requirement()
    expect_s3_class(x, 'tbl_df')
  })
})
