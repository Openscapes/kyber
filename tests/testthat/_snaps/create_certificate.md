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

