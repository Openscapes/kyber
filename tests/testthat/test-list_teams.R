test_that("list_teams works", {
  expect_type(
    list_teams(names_only = TRUE),
    "character"
  )
  expect_s3_class(
    list_teams(names_only = FALSE),
    "data.frame"
  )
})

test_that("list_team_members works", {
  expect_type(
    list_team_members("core-team"),
    "character"
  )
  expect_s3_class(
    list_team_members("core-team", names_only = FALSE),
    "data.frame"
  )
})

test_that("list_team_members fails with non-existent team", {
  expect_snapshot(
    list_team_members("foofy"),
    error = TRUE
  )
})
