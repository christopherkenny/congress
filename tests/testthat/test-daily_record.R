with_mock_dir('t/dairec', {
  test_that('cong_daily_record works', {
    x <- cong_daily_record()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/dairec2', {
  test_that('cong_daily_record no item works', {
    x <- cong_daily_record(volume = 168, issue = 153)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/dairec3', {
  test_that('cong_daily_record with item works', {
    x <- cong_daily_record(volume = 167, issue = 21, item = 'articles')
    expect_s3_class(x, 'tbl_df')
  })
})
