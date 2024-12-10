# create_batch_certificates works

    Code
      list.files(tdir, recursive = TRUE)
    Output
      character(0)

# create_batch_certificates gives message when it fails but still proceeds

    Code
      create_batch_certificates(registry = registry, participants = participants,
        cohort_name = "2024-nmfs-champions-a", cohort_type = "nmfs", output_dir = file.path(
          tdir, "nmfs-a"))
    Message
      x Unable to create certificate for "Sally Green"
      i  Error: character string is not in a standard unambiguous format
    Output
      [1] "output_dirname/nmfs-a"

