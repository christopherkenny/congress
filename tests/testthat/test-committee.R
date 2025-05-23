with_mock_dir('t/committee', {
  test_that('cong_committee works', {
    x <- cong_committee()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/comm', {
  test_that('cong_committee no committee works', {
    x <- cong_committee(chamber = 'house')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/comm2', {
  test_that('cong_committee reports works', {
    x <- cong_committee(chamber = 'senate', committee = 'slpo00', item = 'reports')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/comm3', {
  test_that('cong_committee nominations works', {
    x <- cong_committee(chamber = 'senate', committee = 'slpo00', item = 'nominations')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/comm4', {
  test_that('cong_committee house-communication works', {
    x <- cong_committee(chamber = 'house', committee = 'hspw00', item = 'house-communication')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/comm5', {
  test_that('cong_committee senate-communication works', {
    x <- cong_committee(chamber = 'senate', committee = 'slpo00', item = 'senate-communication')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/comm6', {
  test_that('cong_committee senate-communication works', {
    x <- cong_committee(chamber = 'senate', committee = 'slpo00', item = 'bills')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/comm7', {
  test_that('cong_committee chamber works', {
    x <- cong_committee(congress = 117, chamber = 'house')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/comm8', {
  test_that('cong_committee chamber no congress works', {
    x <- cong_committee(chamber = 'senate', committee = 'jsec03')
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('cong_committee errors with from_date missing to_date', {
  expect_error(cong_committee(congress = 118, from_date = '2023-05-05'))
})
