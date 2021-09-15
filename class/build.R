lesson <- strsplit(here::here(), "/")[[1]]
lesson <- lesson[length(lesson)]

# Build the slides
xaringanBuilder::build_html("index.Rmd", "index.html")
xaringanBuilder::build_pdf("index.html", paste0(lesson, ".pdf"))

# Create zip files of class notes
zip::zipr(
    zipfile = paste0(lesson, ".zip"),
    files = c(
        "bears_solutions.Rmd",
        "bears.Rmd",
        "data",
        "ggplot2_solutions.Rmd",
        "ggplot2.Rmd",
        "rmd_demo.Rmd",
        paste0(lesson, ".Rproj")))
