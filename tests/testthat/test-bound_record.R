with_mock_dir('t/brcd', {
  test_that('cong_bound_record works', {
    x <- cong_bound_record(year = 1948, month = 5, day = 19)
    expect_s3_class(x, 'tbl_df')
  })
})
