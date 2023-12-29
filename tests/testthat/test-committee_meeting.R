with_mock_dir("httptest2/commmeet", {
  test_that("cong_committee_meeting works", {
    x <- cong_committee_meeting()
    expect_s3_class(x, 'tbl_df')
  })
})
