with_mock_dir("httptest2/report", {
  test_that("cong_committee_report works", {
    x <- cong_committee_report()
    expect_s3_class(x, 'tbl_df')
  })
})
