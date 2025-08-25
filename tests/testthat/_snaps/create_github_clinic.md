# Fails with duplicate names

    Code
      create_github_clinic(names = c("julia", "erin", "julia"))
    Condition
      Error in `create_github_clinic()`:
      ! Each name must be unique, but 'julia' is duplicated.

# Interaction with existing file names works (#120)

    Code
      create_github_clinic(kyber::short_names("Stef", "Jones"), dir)
    Condition
      Warning:
      A file named 'stef.md' already exists. It has prepended with `_duplicate_`; please fix manually.

---

    Code
      list.files(file.path(dir, "github-clinic"))
    Output
      [1] "_duplicate_stef.md" "erin_l.md"          "erin_r.md"         
      [4] "stef.md"           

