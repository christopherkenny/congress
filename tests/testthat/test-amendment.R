with_mock_dir('t/amendment', {
  test_that('`cong_amendment()` works', {
    x <- cong_amendment()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/amend1', {
  test_that('`cong_amendment` with item works', {
    x <- cong_amendment(congress = 117, type = 'samdt', number = 2137, item = 'actions')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/amend2', {
  test_that('`cong_amendment()` without item works', {
    x <- cong_amendment(congress = 117, type = 'samdt', number = 2137)
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('`cong_amendment()` errors with from_date missing to_date', {
  expect_error(cong_amendment(from_date = '2023-05-05'))
})

with_mock_dir('t/amend3', {
  test_that("`cong_amendment()` with item = 'text' works", {
    x <- cong_amendment(congress = 117, type = 'samdt', number = 2137, item = 'text')
    expect_s3_class(x, 'tbl_df')
  })
})
