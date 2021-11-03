lesson <- strsplit(here::here(), "/")[[1]]
lesson <- lesson[length(lesson)]

# Build the slides
xaringanBuilder::build_html("index.Rmd", "index.html")
xaringanBuilder::build_pdf("index.html", paste0(lesson, ".pdf"))

# Create zip files of class notes
zip::zipr(
    zipfile = paste0(lesson, ".zip"),
    files = c(
        'cars.Rmd',
        'efficiency.Rmd',
        'powerAnalysis.Rmd',
        'powerAnalysis_interactions.Rmd',
        'practice.Rmd',
        'solutions.html',
        'solutions.Rmd',
        'winePairings.Rmd',
        paste0(lesson, ".Rproj")))


