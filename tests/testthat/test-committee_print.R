with_mock_dir('t/committee_print', {
  test_that('cong_committee_print works', {
    x <- cong_committee_print()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/compri1', {
  test_that('committee_print with item works', {
    x <- cong_committee_print(congress = 117, chamber = 'house', number = '48144', item = 'text')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/compri2', {
  test_that('committee_print without item works', {
    x <- cong_committee_print(congress = 117, chamber = 'house', number = '48144')
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('committee_print errors with from_date missing to_date', {
  expect_error(committee_print(from_date = '2023-05-05'))
})
