teams_created <- create_team("2021-ilm-rotj-team", maintainers = "ateucher")

teams_created

members_added <- add_team_members("2021-ilm-rotj-team", "not-ateucher")

members_added

# Need to go to not-ateucher account and accept invitation

list_team_members("2021-ilm-rotj-team")

members_removed <- remove_team_members(
  "2021-ilm-rotj-team",
  members = "not-ateucher"
)

list_team_members("2021-ilm-rotj-team")

org_members_removed <- remove_org_members("not-ateucher")
