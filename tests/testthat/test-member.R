with_mock_dir("t/member", {
  test_that("cong_member works", {
    x <- cong_member()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/member1", {
  test_that("cong_member with item works", {
    x <- cong_member(bioguide = 'L000174', item = 'sponsored-legislation')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/member2", {
  test_that("cong_member without item works", {
    x <- cong_member(bioguide = 'L000174')
    expect_s3_class(x, 'tbl_df')
  })
})

test_that("cong_member errors with from_date missing to_date", {
  expect_error(cong_member(from_date = '2023-05-05'))
})
