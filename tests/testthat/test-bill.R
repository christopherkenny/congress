with_mock_dir("t/bill", {
  test_that("cong_bill works", {
    x <- cong_bill()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/bill2", {
  test_that("cong_bill without item works", {
    x <- cong_bill(congress = 117, type = 'hr', number = 3076)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/bill3", {
  test_that("cong_bill with item works", {
    x <- cong_bill(congress = 117, type = 'hr', number = 3076, item = 'actions')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/bill4", {
  test_that("cong_bill with item = text works", {
    x <- cong_bill(congress = 117, type = 'hr', number = 3076, item = 'text')
    expect_s3_class(x, 'tbl_df')
  })
})

test_that("cong_bill errors with from_date missing to_date", {
  expect_error(cong_bill(congress = 118, from_date = '2023-05-05'))
})

with_mock_dir("t/bill5", {
  test_that("cong_bill with item = summaries works", {
    x <- cong_bill(congress = 117, type = 'hr', number = 3076, item = 'summaries')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/bill6", {
  test_that("cong_bill with item = committees works", {
    x <- cong_bill(congress = 117, type = 'hr', number = 3076, item = 'committees')
    expect_s3_class(x, 'tbl_df')
  })
})
