setwd("/home/ehnertpp/newspaper-scraping-germany/data/newspaper_articles_germany/")
#path <- "/home/ehnertpp/newspaper-scraping-germany/data/newspaper_articles_germany/"
path <- "./"
folders <- grep(list.files(path = path, full.names = TRUE), pattern = "stats", inv = TRUE, value = TRUE)
anzahl <- sapply(folders, function(folder){
length(list.files(folder, recursive = TRUE, pattern = ".html$"))
})



stats <- data.frame(folder = basename(folders), count = anzahl, datetime = Sys.time())

out <- "./stats.csv"

if (file.exists(out)){
  write.table(stats, file = out, sep = ",", row.names = FALSE, col.names = FALSE, append = TRUE)
} else {
  write.table(stats, file = out, sep = ",", row.names = FALSE, col.names = TRUE)
}

#Zur Visualisierung der anzahl der HTML-Dateien im Zeitverlauf
#stats_full <- read.csv("/Users/ehnertpp/newspaper-scraping-germany/R-Code/stats.csv")
#stats_full$datetime <- as.POSIXct(stats_full$datetime)
#library(ggplot2)
#stats <- ggplot(stats_full, aes(x = datetime, y = count, color = folder)) + 
#geom_line()
#ggsave(filename="Checkup.pdf", plot = stats)