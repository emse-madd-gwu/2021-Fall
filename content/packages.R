# Install packages from CRAN
install.packages(c(
    "cowplot",
    "fastDummies",
    "ggrepel",
    "here",
    "janitor",
    "kableExtra",
    "knitr",
    "logitr",
    "remotes",
    "rmarkdown",
    "tidyverse",
    "viridis",
))

# Install development packages from GitHub
remotes::install_github("jhelvy/logitr")
remotes::install_github("jhelvy/conjointTools")
