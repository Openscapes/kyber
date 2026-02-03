# Get the paths to files installed with kyber

This function allows you to quickly access files that are installed with
kyber.

## Usage

``` r
kyber_file(path = NULL)
```

## Arguments

- path:

  The name of the file. If no argument is provided then all of the
  example files will be listed.

## Value

A vector of file paths

## Examples

``` r
kyber_file("_opening.Rmd")
#> [1] "/home/runner/work/_temp/Library/kyber/agendas/_opening.Rmd"
```
