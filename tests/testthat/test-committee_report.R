with_mock_dir('t/report', {
  test_that('cong_committee_report works', {
    x <- cong_committee_report()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/report1', {
  test_that('cong_committee_report with item works', {
    x <- cong_committee_report(congress = 116, type = 'hrpt', number = 617, item = 'text')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/report2', {
  test_that('cong_committee_report without item works', {
    x <- cong_committee_report(congress = 116, type = 'hrpt', number = 617)
    expect_s3_class(x, 'tbl_df')
  })
})
