with_mock_dir("t/s_comm", {
  test_that("cong_senate_communication works", {
    x <- cong_senate_communication()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/s_comm1", {
  test_that("cong_senate_communication with number works", {
    x <- cong_senate_communication(congress = 117, type = 'ec', number = 2561)
    expect_s3_class(x, 'tbl_df')
  })
})


test_that("cong_senate_communication errors with from_date missing to_date", {
  expect_error(cong_senate_communication(from_date = '2023-05-05'))
})
