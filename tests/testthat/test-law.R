with_mock_dir('t/law', {
  test_that('`cong_law()` works', {
    x <- cong_law()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/law2', {
  test_that('`cong_law()` with type = pub works', {
    x <- cong_law(congress = 118, type = 'pub')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/law3', {
  test_that('`cong_law()` with number returns single law', {
    x <- cong_law(congress = 118, type = 'pub', number = 108)
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('`cong_law()` errors with from_date missing to_date', {
  expect_error(cong_law(congress = 118, from_date = '2023-05-05'))
})
