setwd("/home/ehnertpp/newspaper-scraping-germany/")
move <- function(agency, kategorie) {
  
  for (kat in kategorie)
  {
    for (agentur in agency)
      {
        from.folder <- paste0("./data/newspaper_articles_germany/", agentur, "/", kat, "/")
        to.folder <- paste0("./Archiv/", agentur, "/", kat, "/")
        list.of.files <- list.files(from.folder, "\\.html$", full.names = TRUE)
        file.copy(list.of.files, to.folder, overwrite = TRUE, recursive = FALSE)
        do.call(file.remove, list(list.files(paste0("./data/newspaper_articles_germany/", agentur, "/", kat, "/"), full.names = TRUE)))
      }
  }
}

agency <- c("ard","bild","faz","focus","freitag","gmx","jungefreiheit","ntv","spiegel","stern","sueddeutsche","tagesspiegel","tonline","webde","welt","yahoode","zeit")

kategorie <- c("articles","indices")

move(agency, kategorie)