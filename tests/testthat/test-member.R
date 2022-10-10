with_mock_dir("httptest2/member", {
  test_that("cong_member works", {
    x <- cong_member()
    expect_s3_class(x, 'tbl_df')
  })
})
