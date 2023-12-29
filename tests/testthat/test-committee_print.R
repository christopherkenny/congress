with_mock_dir("httptest2/committee_print", {
  test_that("cong_committee_print works", {
    x <- cong_committee_print()
    expect_s3_class(x, 'tbl_df')
  })
})
