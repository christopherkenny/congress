with_mock_dir("httptest2/summaries", {
  test_that("cong_summaries works", {
    x <- cong_summaries()
    expect_s3_class(x, 'tbl_df')
  })
})
