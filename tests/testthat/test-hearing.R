with_mock_dir("t/hearing", {
  test_that("cong_hearing works", {
    x <- cong_hearing()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/hearing1", {
  test_that("cong_hearing with item works", {
    x <- cong_hearing(congress = 116, chamber = 'house', number = 41365)
    expect_s3_class(x, 'tbl_df')
  })
})
