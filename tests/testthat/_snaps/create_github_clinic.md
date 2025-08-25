# Interaction with duplicated names works (#120)

    Code
      create_github_clinic(kyber::short_names("Stef", "Jones"), dir)
    Condition
      Error:
      ! [EEXIST] Failed to copy '/Users/andy/dev/openscapes/kyber/inst/kyber-templates/github_clinic_md_text.md' to '/var/folders/_f/n9fw7ctx3fqf2ty9ylw502g80000gn/T/Rtmppw0ZIi/github-clinic/stef.md': file already exists

