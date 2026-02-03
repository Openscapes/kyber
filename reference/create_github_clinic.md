# Create GitHub Clinic Files

Create GitHub Clinic Files

## Usage

``` r
create_github_clinic(names, path = getwd())
```

## Arguments

- names:

  A vector of names for the markdown files that should be created. The
  `.md` extension will be added automatically. The names should be
  unique. If there exists a file with the same name in the target
  directory, the new file will be prepended with `_duplicate_` and a
  warning will be issued.

- path:

  Path to the directory where `github-clinic` should be created.

## Examples

``` r
if (FALSE) { # \dontrun{

create_github_clinic(names = c("julia", "erin"))

file.exists("github-clinic")
#> TRUE

list.files("github-clinic")
#> "erin.md"  "julia.md"
} # }
```
