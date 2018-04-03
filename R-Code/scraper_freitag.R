#!/usr/local/bin/Rscript
setwd("/Users/ehnertpp/newspaper-scraping-germany")
source("./R-Code/functions.R")
agentur <- "freitag"
input <- paste0("./data/newspaper_articles_germany/", agentur, "/indices" )
output <- paste0("./data/newspaper_articles_germany/", agentur, "/articles" )

# source functions and list of rss-feeds 


rss_feeds <- sapply(Filter(function(x) x$agency == agentur, rss_feeds), "[[", "url")

# run scraper:
scraper_headlines(folder = input, rss_feeds, agency = agentur)
scraper_articles(folderInput = input, folderOutput = output, agency = agentur)
