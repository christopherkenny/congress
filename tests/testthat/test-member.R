with_mock_dir('t/member', {
  test_that('cong_member works', {
    x <- cong_member()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/member1', {
  test_that('cong_member with item works', {
    x <- cong_member(bioguide = 'L000174', item = 'sponsored-legislation')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/member2', {
  test_that('cong_member without item works', {
    x <- cong_member(bioguide = 'L000174')
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('cong_member errors with from_date missing to_date', {
  expect_error(cong_member(from_date = '2023-05-05'))
})

with_mock_dir('t/member3', {
  test_that('cong_member with just congress works', {
    x <- cong_member(congress = 117)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/member4', {
  test_that('cong_member with just state works', {
    x <- cong_member(state = 'NY')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/member5', {
  test_that('cong_member with state + district works', {
    x <- cong_member(state = 'NY', district = 2)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/member6', {
  test_that('cong_member with congress + state + district works', {
    x <- cong_member(congress = 117, state = 'NY', district = 2)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/member7', {
  test_that('cong_member with congress + state works', {
    x <- cong_member(congress = 117, state = 'NY')
    expect_s3_class(x, 'tbl_df')
  })
})
