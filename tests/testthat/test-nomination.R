with_mock_dir('t/nomination', {
  test_that('cong_nomination works', {
    x <- cong_nomination()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/nomination1', {
  test_that('cong_nomination with item works', {
    x <- cong_nomination(congress = 117, number = 2467, item = 'actions')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/nomination2', {
  test_that('cong_nomination without item works', {
    x <- cong_nomination(congress = 117, number = 2467)
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('cong_nomination errors with from_date missing to_date', {
  expect_error(cong_nomination(from_date = '2023-05-05'))
})
