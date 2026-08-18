# Changelog

## kyber 0.3.0

- Added two new functions
  ([\#174](https://github.com/Openscapes/kyber/issues/174)):
  - [`remove_team_members()`](https://openscapes.github.io/kyber/reference/remove_team_members.md)
    for removing a list of people from a GitHub team
  - [`remove_org_members()`](https://openscapes.github.io/kyber/reference/remove_org_members.md)
    for removing people from an organization.
- Auto-populate the website link at the top of `agenda.md` from the
  `cohort_website` column in the registry
  ([\#170](https://github.com/Openscapes/kyber/issues/170),
  [\#193](https://github.com/Openscapes/kyber/issues/193))
- Group efficiency and inclusion tips under an “Open Science Tips of the
  Day” heading, change “PC” to “Windows”, and remove custom purple font
  colour from the Zoom link
  ([\#171](https://github.com/Openscapes/kyber/issues/171),
  [\#178](https://github.com/Openscapes/kyber/issues/178),
  [\#180](https://github.com/Openscapes/kyber/issues/180),
  [\#191](https://github.com/Openscapes/kyber/issues/191))
- Agenda output file is now named `agenda_call_[call-number].md`, and
  [`call_agenda()`](https://openscapes.github.io/kyber/reference/call_agenda.md)
  now messages the user where the file was written
  ([\#179](https://github.com/Openscapes/kyber/issues/179),
  [\#187](https://github.com/Openscapes/kyber/issues/187),
  [\#188](https://github.com/Openscapes/kyber/issues/188),
  [\#190](https://github.com/Openscapes/kyber/issues/190))
- Replace Twitter/X links with Bluesky (or website) for Openscapes,
  Allison Horst, and Kara Woo
  ([\#173](https://github.com/Openscapes/kyber/issues/173),
  [\#175](https://github.com/Openscapes/kyber/issues/175),
  [\#185](https://github.com/Openscapes/kyber/issues/185),
  [\#186](https://github.com/Openscapes/kyber/issues/186))
- Fix a broken Openscapes link in the README template
  ([\#181](https://github.com/Openscapes/kyber/issues/181),
  [\#183](https://github.com/Openscapes/kyber/issues/183))
- Small update to Closing, Call 4: add the goal and move timing points
  closer together
  ([\#184](https://github.com/Openscapes/kyber/issues/184))

## kyber 0.2.0

- Ensure total duration of call agendas == sum of section durations
  ([\#66](https://github.com/Openscapes/kyber/issues/66))
- Move Pathways Certificates into kyber
  ([\#99](https://github.com/Openscapes/kyber/issues/99))
- Check cohort_id value against cohort_name column in registry
  ([\#161](https://github.com/Openscapes/kyber/issues/161),
  [\#117](https://github.com/Openscapes/kyber/issues/117))
- Create NMFS-specific completion certificate
  ([\#144](https://github.com/Openscapes/kyber/issues/144))
- Improve behaviour when adding `name.md` files in batches and
  encountering duplicates
  ([\#120](https://github.com/Openscapes/kyber/issues/120))
- cohort parameter in `README.Rmd` yaml frontmatter now defaults to repo
  name ([\#152](https://github.com/Openscapes/kyber/issues/152))
- Reordered sections in certificates vignette
  ([\#154](https://github.com/Openscapes/kyber/issues/154))
- Make landscape image appear in Call 1 agenda welcome
  ([\#158](https://github.com/Openscapes/kyber/issues/158))
- Fix strange boxes appearing in agenda
  ([\#160](https://github.com/Openscapes/kyber/issues/160))
- Use `Air` for code formatting consistency
  ([\#164](https://github.com/Openscapes/kyber/issues/164))
