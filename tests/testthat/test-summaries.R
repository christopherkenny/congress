with_mock_dir('t/summaries', {
  test_that('cong_summaries works', {
    x <- cong_summaries()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/summaries1', {
  test_that('cong_summaries with type works', {
    x <- cong_summaries(congress = 117, type = 'hr')
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('cong_summaries errors with from_date missing to_date', {
  expect_error(cong_summaries(congress = 118, from_date = '2023-05-05'))
})
