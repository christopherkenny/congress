test_that('has_congress_key works', {
  expect_true(is.logical(has_congress_key()))
})

test_that('get_congress_key works', {
  expect_true(is.character(get_congress_key()))
})

test_that('set_congress_key works', {
  testthat::skip_if_not_installed('withr')
  withr::with_envvar(
    c('CONGRESS_KEY' = NA_character_),
    expect_true(is.list(set_congress_key('1234')))
  )

  withr::with_envvar(
    c('CONGRESS_KEY' = NA_character_),
    expect_error(set_congress_key())
  )
})
