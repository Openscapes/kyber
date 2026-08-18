# kyber 0.3.0

* Added two new functions (#174):
    - `remove_team_members()` for removing a list of people from a GitHub team
    - `remove_org_members()` for removing people from an organization.
* Auto-populate the website link at the top of `agenda.md` from the `cohort_website` column in the registry (#170, #193)
* Group efficiency and inclusion tips under an "Open Science Tips of the Day" heading, change "PC" to "Windows", and remove custom purple font colour from the Zoom link (#171, #178, #180, #191)
* Agenda output file is now named `agenda_call_[call-number].md`, and `call_agenda()` now messages the user where the file was written (#179, #187, #188, #190)
* Replace Twitter/X links with Bluesky (or website) for Openscapes, Allison Horst, and Kara Woo (#173, #175, #185, #186)
* Fix a broken Openscapes link in the README template (#181, #183)
* Small update to Closing, Call 4: add the goal and move timing points closer together (#184)

# kyber 0.2.0

* Ensure total duration of call agendas == sum of section durations (#66)
* Move Pathways Certificates into kyber (#99)
* Check cohort_id value against cohort_name column in registry (#161, #117)
* Create NMFS-specific completion certificate (#144)
* Improve behaviour when adding `name.md` files in batches and encountering duplicates (#120)
* cohort parameter in `README.Rmd` yaml frontmatter now defaults to repo name (#152)
* Reordered sections in certificates vignette (#154)
* Make landscape image appear in Call 1 agenda welcome (#158)
* Fix strange boxes appearing in agenda (#160)
* Use `Air` for code formatting consistency (#164)
