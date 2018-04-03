#!/usr/local/bin/Rscript

setwd("/Users/ehnertpp/newspaper-scraping-germany")

  
parser_spiegel_articles <- function(folderInput) {
  # load packages
  require(rvest)
  require(purrr)
  require(magrittr)
  require(lubridate)
  require(stringr)
  # import htmls
  htmls <- list.files(folderInput, pattern = ".+html$", full.names = TRUE)
  html_list <- lapply(htmls, read_html)
  # parser function for css snippets
  page_parser <- function(css, attr = "", multi = FALSE) {
    if (multi == TRUE){ # extract multiple elements (paragraphs)
    sapply(html_list, function(x) { html_nodes(x, css = css) %>% html_text()}) %>% lapply(function(x) {str_replace_all(x, "\\r|\\n|\\t", "") %>% paste(sep=" ", collapse=" ")}) %>% unlist()
    }else if (str_length(attr) == 0) { # extract element value
    sapply(html_list, function(x) { html_nodes(x, css = css) %>% html_text() %>% extract(1)}) %>% map(1) %>% lapply(function(x) ifelse(is_null(x), "", x)) %>%   unlist()
    }else{ # extract attribute value
    sapply(html_list, function(x) { html_nodes(x, css = css) %>% html_attr(attr) %>% extract(1)}) %>% map(1) %>% lapply(function(x) ifelse(is_null(x), "", x)) %>%   unlist()
    }
  }
  # parse info
  headline <- page_parser(".headline") # in xpath, this would be something like: 
  headline_intro <- page_parser(".headline-intro")
  datetime <- page_parser(".timeformat", attr = "datetime") %>% ymd_hms(tz = "Europe/Berlin")
  domain <- page_parser(".current-channel-name")
  text_intro <- page_parser(".article-intro")
  text <- page_parser("#js-article-column li , p", multi = TRUE)
  # merge to data frame; return
  articles_dat <- data.frame(outlet = "http://www.spiegel.de",
                             file = htmls,
                             headline, 
                             headline_intro,
                             datetime,
                             domain,
                             text_intro,
                             text,
                             stringsAsFactors = FALSE
                             )
  articles_dat
}


library(rvest)
url <- "http://www.spiegel.de/politik/deutschland/afd-frauke-petry-bestreitet-absichtliche-falschaussage-a-1171252.html"
url_parsed <- read_html(url)
html_nodes(url_parsed, ".headline-intro") %>% html_text  ### CSS selector style
html_nodes(url_parsed, xpath = "//span[@class='headline-intro']") %>% html_text  ### XPath expression style

  
# to do's
  # add parameters: author, comments, raw text
  # clean dump of parsed data into database

folder <- "../data_example/newspaper_articles_germany/spiegel/articles"
folderInput <- folder
foo <- parser_spiegel_articles(folder)


# PROBLEM WITH byte-zero files
# PROBLEM WITH datetime <- page_parser(".timeformat", attr = "datetime") %>% ymd_hms(tz = "Europe/Berlin"); see https://stackoverflow.com/questions/42143323/error-in-as-posixlt-posixctx-tz-converted-from-warning-unknown-timezone



# import htmls
htmls <- list.files(folderInput, pattern = ".+html$", full.names = TRUE)
html_list <- lapply(htmls, read_html)
# parser function for css snippets
page_parser <- function(css, attr = "", multi = FALSE) {
  if (multi == TRUE){ # extract multiple elements (paragraphs)
    sapply(html_list, function(x) { html_nodes(x, css = css) %>% html_text()}) %>% lapply(function(x) {str_replace_all(x, "\\r|\\n|\\t", "") %>% paste(sep=" ", collapse=" ")}) %>% unlist()
  }else if (str_length(attr) == 0) { # extract element value
    sapply(html_list, function(x) { html_nodes(x, css = css) %>% html_text() %>% extract(1)}) %>% map(1) %>% lapply(function(x) ifelse(is_null(x), "", x)) %>%   unlist()
  }else{ # extract attribute value
    sapply(html_list, function(x) { html_nodes(x, css = css) %>% html_attr(attr) %>% extract(1)}) %>% map(1) %>% lapply(function(x) ifelse(is_null(x), "", x)) %>%   unlist()
  }
}
# parse info
headline <- page_parser(".headline")
headline_intro <- page_parser(".headline-intro")
datetime <- page_parser(".timeformat", attr = "datetime") %>% ymd_hms(tz = "Europe/Berlin")
domain <- page_parser(".current-channel-name")
text_intro <- page_parser(".article-intro")
text <- page_parser("#js-article-column li , p", multi = TRUE)
# merge to data frame; return
articles_dat <- data.frame(outlet = "http://www.spiegel.de",
                           file = htmls,
                           headline, 
                           headline_intro,
                           datetime,
                           domain,
                           text_intro,
                           text,
                           stringsAsFactors = FALSE
)
articles_dat




