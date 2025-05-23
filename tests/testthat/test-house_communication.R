with_mock_dir('t/h_comm', {
  test_that('cong_house_communication works', {
    x <- cong_house_communication()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/h_comm1', {
  test_that('cong_house_communication with number works', {
    x <- cong_house_communication(congress = 117, type = 'ec', number = 3324)
    expect_s3_class(x, 'tbl_df')
  })
})


test_that('cong_house_communication errors with from_date missing to_date', {
  expect_error(cong_house_communication(from_date = '2023-05-05'))
})
