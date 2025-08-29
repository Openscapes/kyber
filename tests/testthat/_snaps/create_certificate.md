# create_batch_certificates works

    Code
      list.files(tdir, recursive = TRUE)
    Output
      [1] "nasa/OpenscapesCertificate_2024-champions_Leo-Blue.pdf"             
      [2] "nasa/OpenscapesCertificate_2024-champions_Lily-Brown.pdf"           
      [3] "nmfs-a/OpenscapesCertificate_2024-nmfs-champions-a_Rupert-White.pdf"
      [4] "nmfs-a/OpenscapesCertificate_2024-nmfs-champions-a_Sally-Green.pdf" 

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

# create_batch_pathways_certificates works with defaults

    Code
      list.files(tdir, recursive = TRUE)
    Output
      [1] "pathways/Certificate_Pathways-to-Open-Science-2024_Firstname-Lastname.pdf"           
      [2] "pathways/Certificate_Pathways-to-Open-Science-2024_Firstname-MiddleName-Lastname.pdf"

# create_batch_pathways_certificates proceeds with warning when one column with unexpected name

    Code
      suppressMessages(create_batch_pathways_certificates(participants = participants,
        start_date = "2024-01-01", end_date = "2024-02-01", output_dir = file.path(
          tdir, "pathways")))
    Condition
      Warning:
      Did not find a "participant_name" column in the "participants" data.frame, but there is one column named "other_name".  Using that column.
    Output
      

---

    Code
      list.files(tdir, recursive = TRUE)
    Output
      [1] "pathways/Certificate_Pathways-to-Open-Science-2024_Firstname-Lastname.pdf"           
      [2] "pathways/Certificate_Pathways-to-Open-Science-2024_Firstname-MiddleName-Lastname.pdf"

# create_batch_pathways_certificates errors when > 1 unexpected column

    Code
      suppressMessages(create_batch_pathways_certificates(participants = participants,
        start_date = "2024-01-01", end_date = "2024-02-01", output_dir = file.path(
          tdir, "pathways")))
    Condition
      Error in `get_participant_names()`:
      ! There should be a single column called "participant_name" in the "participants" data.frame

# create_batch_pathways_certificates works with a character vector

    Code
      list.files(tdir, recursive = TRUE)
    Output
      [1] "pathways/Certificate_Pathways-to-Open-Science-2024_Firstname-Lastname.pdf"           
      [2] "pathways/Certificate_Pathways-to-Open-Science-2024_Firstname-MiddleName-Lastname.pdf"

# create_batch_pathways_certificates works specifying more args

    Code
      list.files(tdir, recursive = TRUE)
    Output
      [1] "pathways/Certificate_test-pathways-cohort-2024_Firstname-Lastname.pdf"           
      [2] "pathways/Certificate_test-pathways-cohort-2024_Firstname-MiddleName-Lastname.pdf"

