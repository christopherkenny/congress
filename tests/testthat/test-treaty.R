with_mock_dir("t/treaty", {
  test_that("cong_treaty works", {
    x <- cong_treaty()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/treaty1", {
  test_that("cong_treaty with item works", {
    x <- cong_treaty(congress = 114, number = 13, suffix = 'A', item = 'actions')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/treat2", {
  test_that("cong_treaty without item works", {
    x <- cong_treaty(congress = 117, number = 3)
    expect_s3_class(x, 'tbl_df')
  })
})

test_that("cong_treaty errors with from_date missing to_date", {
  expect_error(cong_treaty(congress = 118, from_date = '2023-05-05'))
})
