lesson <- strsplit(here::here(), "/")[[1]]
lesson <- lesson[length(lesson)]

# Build the slides
xaringanBuilder::build_html("index.Rmd", "index.html")
xaringanBuilder::build_pdf("index.html", paste0(lesson, ".pdf"))

# Create zip files of class notes
zip::zipr(
    zipfile = paste0(lesson, ".zip"),
    files = c(
        'data',
        'images',
        'make_choice_questions.R',
        'p2-choice-questions-table.Rmd',
        'p2-choice-questions.Rmd',
        paste0(lesson, ".Rproj")))
