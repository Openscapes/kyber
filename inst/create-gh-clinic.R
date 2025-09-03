## Example script for AFSC cohort

## load libraries
library(kyber)
library(rmarkdown)
library(tibble)
library(fs)
library(googlesheets4)
library(tidyverse)

## load data
raw_sheet <- googlesheets4::read_sheet(
  "https://docs.google.com/spreadsheets/d/13UPh5g5xPTJ8kkji4nO6Rq55o-VI17SjqKQdvxvnoho/edit#gid=0"
)


## create members object
members <- raw_sheet %>%
  select(
    "First" = `First Name`,
    "Last" = `Last Name`,
    "GitHub" = `GitHub username`
  )

## create github_clinic folder with .mds for each member
ky_short_names(members$First, members$Last) |>
  ky_create_github_clinic()

## filter for na GH names
members <- members %>%
  filter(!is.na(GitHub)) %>%
  filter(!(GitHub %in% c("jimianelli-NOAA", "geoff.mayhew", "MikeLevine-NOAA")))


## create repo and team name
repo_name <- "2022-noaa-afsc"
team_name <- paste0(repo_name, "-team")

## create GitHub team, add team members, agnostic of the repo!
ky_create_team(team_name, maintainers = "jules32")
ky_add_team_members(team_name, members = members$GitHub)
ky_add_repo_to_team(repo_name, team_name)
