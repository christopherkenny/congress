with_mock_dir('t/h_req', {
  test_that('cong_house_requirement works', {
    x <- cong_house_requirement()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/h_req1', {
  test_that('cong_house_requirement with item works', {
    x <- cong_house_requirement(number = 8070, 'matching-communications')
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/h_req2', {
  test_that('cong_house_requirement without item works', {
    x <- cong_house_requirement(number = 12478)
    expect_s3_class(x, 'tbl_df')
  })
})

test_that('cong_house_requirement errors with from_date missing to_date', {
  expect_error(cong_house_requirement(from_date = '2023-05-05'))
})
