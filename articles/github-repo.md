# Creating a Cohort-Specific GitHub Repository with Kyber

## Configure GitHub

Make sure your computer is configured according to the instructions in
[`vignette("configuration")`](https://openscapes.github.io/kyber/articles/configuration.md).
Run the following code to see if your GitHub credentials are set up:

``` r

library(gitcreds)
gitcreds_get()
```

If credentials are detected you should get a result like:

    <gitcreds>
      protocol: https
      host    : github.com
      username: PersonalAccessToken
      password: <-- hidden -->

## Creating the Repository

Each Champions Cohort has its own GitHub repository. The name of the
repository should match the corresponding `cohort_name` in the [Cohort
Registry](https://openscapes.github.io/kyber/articles/cr). The
[`init_repo()`](https://openscapes.github.io/kyber/reference/init_repo.md)
function in the code below will do the following:

1.  It checks to see if the GitHub repository you are trying to create
    already exists. If it does exist, it will result in an error.
2.  It tries to initialize a GitHub repository on your computer. If that
    repository already exists in the `path` argument, it will result in
    an error. No repository will have been created on GitHub.
3.  It will then create the local Git repository, add a code of conduct
    (via
    [`add_code_of_conduct()`](https://openscapes.github.io/kyber/reference/add_code_of_conduct.md)),
    add a `.gitignore` file (via
    [`add_gitignore()`](https://openscapes.github.io/kyber/reference/add_gitignore.md)),
    and then `git add` and `git commit` those files before
    `git push`-ing those files to GitHub.
4.  Finally it will create a `README.Rmd` file in the repository for you
    to edit.

``` r

library(kyber) 

repo_name <- "2021-ilm-rotj"

repo_path <- init_repo(repo_name)
```
