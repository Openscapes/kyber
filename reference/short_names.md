# Make unique combinations of first and last names

Make unique combinations of first and last names

## Usage

``` r
short_names(first, last)
```

## Arguments

- first:

  A vector of first names.

- last:

  A vector of last names.

## Examples

``` r
if (FALSE) { # \dontrun{

first <- c("a", "b", "c")
last <- c("x1", "y2", "z3")
short_names(first, last)
#> "a" "b" "c"

first <- c("a", "a", "c")
last <- c("x1", "y2", "z3")
short_names(first, last)
#> "a_x" "a_y" "c"

first <- c("a", "a", "c")
last <- c("x144", "x255", "z3")
short_names(first, last)
#> "a_x144" "a_x255" "c"

first <- c("a", "a", "c", "d", "d")
last <- c("x144", "x255", "z3", "r4", "t5")
short_names(first, last)
#> "a_x144" "a_x255" "c"      "d_r"    "d_t"

first <- c("a", "a", "c")
last <- c("x1", "x1", "z3")
short_names(first, last)
#> "a_x1" "c"
#> Warning message:
#> In ky_short_names(first, last) :
#> First and Last pairs are not unique. Returning only unique combinations.
} # }
```
