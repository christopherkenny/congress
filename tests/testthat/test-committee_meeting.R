with_mock_dir("t/meet", {
  test_that("cong_committee_meeting works", {
    x <- cong_committee_meeting()
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/meet1", {
  test_that("cong_member with item works", {
    x <- cong_committee_meeting(congress = 118, chamber = 'house', number = '115538')
    expect_s3_class(x, 'tbl_df')
  })
})
