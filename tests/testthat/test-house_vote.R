with_mock_dir('t/housevote', {
  test_that('`cong_house_vote()` works', {
    x <- cong_house_vote()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/housevote2', {
  test_that('`cong_house_vote()` with vote number works', {
    x <- cong_house_vote(congress = 119, session = 1, number = 17)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/housevote3', {
  test_that('`cong_house_vote()` with item = members works', {
    x <- cong_house_vote(congress = 119, session = 1, number = 17, item = 'members')
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('`cong_house_vote()` errors with from_date missing to_date', {
  expect_error(cong_house_vote(from_date = '2025-01-01'))
})
