with_mock_dir('t/crsreport', {
  test_that('`cong_crs_report()` works', {
    x <- cong_crs_report()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/crsreport2', {
  test_that('`cong_crs_report()` returns a single report', {
    x <- cong_crs_report(crs_id = '93-792')
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('`cong_crs_report()` errors with from_date missing to_date', {
  expect_error(cong_crs_report(from_date = '2023-01-01'))
})
