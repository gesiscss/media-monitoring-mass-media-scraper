parser_articles <- function(agency, headline, headline_intro, datetime, domain, text_intro, text, paywall, tweets) {
  # load packages
  require(rvest)
  require(purrr)
  require(magrittr)
  require(lubridate)
  require(stringr)
  require(httr)
  require(xml2)
  require(RMySQL)
  folderInput <- paste0("/home/ehnertpp/newspaper-scraping-germany/Archiv/", agency ,"/articles/")
  folderOutput <- paste0("/home/ehnertpp/newspaper-scraping-germany/Archiv/", agency,"/parsed/")

  # import htmls
  htmls <- list.files(folderInput, pattern = ".+html$", full.names = TRUE)
  htmls <- htmls[lapply(htmls, file.size) > 10000]
  con <- dbConnect(MySQL(), user="root", password ="", host="127.0.0.1", dbname="articles")
  counter <- 0
  while(length(htmls) > 1)
  {
    htmllist <- list.files(folderInput, pattern = ".+html$", full.names = T)[1:100] 
    htmllist <- htmllist[lapply(htmllist, file.size) > 10000]
    htmllist <- na.exclude(htmllist)
    counter <- counter + length(htmllist)
    html_list <- lapply(htmllist, function(x){ read_html(x, encoding = "UTF-8", options = c("RECOVER", "NOERROR"))})
    # parser function for css snippets
    page_parser <- function(css, attr = "", multi = FALSE) {

      if (str_length(attr) == 0 && str_length(css) == 0 && multi == TRUE)
      {
        sapply(html_list, function(x) {str_extract_all(x, "status\\/([0-9]{18,21}?)", simplify = TRUE) %>% lapply(function(x) gsub("status\\/([0-9]{18,21})", "\\1", x)) %>% lapply(function(x) ifelse(is_null(x), "", x)) %>% paste(sep=" ", collapse=" ")}) %>% unlist()
      } else if (multi == TRUE && str_length(attr) != 0)
      {
        sapply(html_list, function(x) { html_nodes(x, css = css) %>% html_attr(attr)}) %>% lapply(function(x) {str_replace_all(x, "\\r|\\n|\\t", "") %>% paste(sep=" ", collapse=" ")}) %>% unlist()
      }
      else if (multi == TRUE){ # extract multiple elements (paragraphs)
        sapply(html_list, function(x) { html_nodes(x, css = css) %>% html_text()}) %>% lapply(function(x) {str_replace_all(x, "\\r|\\n|\\t", "") %>% paste(sep=" ", collapse=" ")}) %>% unlist()
      }else if (str_length(attr) == 0) { # extract element value
        sapply(html_list, function(x) { html_node(x, css = css) %>% html_text() %>% extract(1)})  %>% map(1) %>% lapply(function(x) ifelse(is_null(x), "", x)) %>%  lapply(function(x) {str_replace_all(x, "\\r|\\n|\\t", "") %>% paste(sep=" ", collapse=" ")}) %>% unlist()
      }
      else if (str_length(attr) != 0){ # extract attribute value
        sapply(html_list, function(x) { html_node(x, css = css) %>% html_attr(attr) %>% extract(1)}) %>% map(1) %>% lapply(function(x) ifelse(is_null(x), "", x)) %>%  lapply(function(x) {str_replace_all(x, "\\r|\\n|\\t", "") %>% paste(sep=" ", collapse=" ")}) %>% unlist()
      }
      
    }
    #Aufruf der Unterfunktion page_parser mit den in der Hauptfunktion ?bergebenen Parametern
    headline <- page_parser(headline_css, attr = headline_attr, multi =  headline_multi)
    headline_intro <- page_parser(headline_intro_css, attr = headline_intro_attr, multi = headline_intro_multi)
    datetime <- page_parser(datetime_css, attr = datetime_attr, multi = datetime_multi)
    domain <- page_parser(domain_css, attr = domain_attr, multi = domain_multi)
    text_intro <- page_parser(text_intro_css, attr = text_intro_attr, multi = text_intro_multi)
    text <- page_parser(text_css, attr = text_attr, multi = text_multi)
    paywall <- page_parser(paywall_css, attr = paywall_attr, multi = paywall_multi)
    tweets <- page_parser(tweets_css, attr = tweets_attr, multi = tweets_multi)
    
    #Tweet-IDs aus den Strings befreien
    tweets <- gsub("(.*?\\/)([0-9]{15,21})", "\\2 ", tweets, perl = TRUE)
    tweets <- gsub("(.*)(\\?.*)", "\\1 ", tweets, perl = TRUE)
    tweets <- gsub("([h|'].*$)", "", tweets, perl = TRUE)     
    #Leerzeichen vor und nach dem String k?rzen 
    headline <- trimws(headline, which = "both")
    headline_intro <- trimws(headline_intro, which = "both")
    datetime <- trimws(datetime, which = "both")
    domain <- trimws(domain, which = "both")
    text_intro <- trimws(text_intro, which = "both")
    text <- trimws(text, which = "both")
    paywall <- trimws(paywall, which = "both")
    tweets <- trimws(tweets, which = "both")
    
    #Wenn zus?tzlich Regex oder ?berarbeitungen erforderlich sind, werden hier die Ausnahmen definiert
    if (agency == "ard")
    {
      text <- gsub("(?i)(.*[.])( .*Stand:.*$)", "\\1", ignore.case = TRUE, text)
    }
    
    if (agency == "bild")
    {
      text <- gsub("(?i)(.*[.])( .*Facebook.*$)", "\\1", ignore.case = TRUE, text)
      paywall <- gsub("free", "NA", paywall )
    }
    
    if (agency == "focus")
    {
      text <- gsub("(?i)(.*[.])(  .*\\*Der Beitrag.*$)", "\\1", ignore.case = TRUE, text)
    }
    
    if (agency == "freitag")
    {
      text_intro <- gsub("(.*)          (.*)", "\\2", text_intro)
    }
    
    if (agency == "jungefreiheit")
    {
      text <- gsub("(.*\\.)(.*)$", "\\1", ignore.case = TRUE, text)
      text <- gsub("^([A-Z]{2,}\\.)(.*)", "\\2", ignore.case = TRUE, text)
    }
    
    if (agency == "spiegel")
    {
      domain <- gsub("\\&","", domain)
      text <- gsub("(?i)(\\bSPIEGEL ONLINE[:]{0,1} \\b|\\bSPIEGEL\\b)", "", text, perl = TRUE)
    }
    
    if (agency == "sueddeutsche")
    {
      paywall <- gsub("SZ-Plus-Abonnenten lesen auch\\:", "SZplus", paywall)
    }
    
    if (agency == "tagesspiegel")
    {
      text <- gsub("(.*\\.)(.*)$", "\\1", ignore.case = TRUE, text)
    }
    
    #Erstellung des Dataframes
    articles_dat <- data.frame(outlet = agency,
                               file = htmllist,
                               headline, 
                               headline_intro,
                               datetime,
                               domain,
                               text_intro,
                               text,
                               paywall,
                               tweets,
                               stringsAsFactors = FALSE
    )
    articles_dat
    
    dbWriteTable(con, name = "articles_table", articles_dat, append = TRUE, row.names=FALSE)
    
    file.copy(htmllist, folderOutput, recursive = TRUE, overwrite = TRUE)
    
    unlink(htmllist)
    htmls <- list.files(folderInput, pattern = ".+html$", full.names = T)
    htmls <- htmls[lapply(htmls, file.size) > 10000]
    ausgabe <- paste0("Bisher wurden ", counter, " Artikel von ", agency, " geparsed")
    message(ausgabe)
  }
  on.exit(dbDisconnect(con))
}



# parse info ard
agency <- 'ard'
headline_css <- '.NewsArticle-title, .detail_headline > *:not(em), .text__headline, .headline+ .small, .headline, .roofline, .col3 > h4, .detail_headline > *:not(em), .topline, header > h1'
headline_attr <- ''
headline_multi <- FALSE
headline_intro_css <- '.NewsArticle-headline, .detail_headline > em, .text__topline, .dachzeile+ .small, .dachzeile, .titletext, .col3 > h1, .detail_headline > em, span[itemprop=headline], .subbranding'
headline_intro_attr <- ''
headline_intro_multi <- FALSE
datetime_css <- 'meta[name=DCTERMS\\.created],meta[property=og\\:article\\:published_time], meta[name=date], meta[name=DC\\.Date], time[class=archivedisclaimer], meta[name=DCTERMS\\.date], meta[name=date], span[itemprop=uploadDate]'
datetime_attr <- 'content'
datetime_multi <- FALSE
domain_css <- '.list-entry-link, .-current, .Header-category, dd[data-orig=Nachrichten], span[itemprop=title], .breadcrumb .uebersicht, ol.breadcrumb > .active, #navAct2, #navigation > .active > .subnav > li > a.active , .contenttype_standard > span, span.active'
domain_attr <- ''
domain_multi <- FALSE
text_intro_css <- '.article-intro, .NewsArticle-teasertext, .text__copytext > strong, .text > strong, .einleitung, .intro, .detail_lead, .lead'
text_intro_attr <- ''
text_intro_multi <- FALSE
text_css <- '.article-section > p:not(.article-intro), .NewsArticle-text > p, p.text__copytext:not(strong), .small+ .text, .longText > p, .box > p:not(.einleitung), .copytext > p, .bodytext > p, .longText > p, .detail_content > .copytext'
text_attr <- ''
text_multi <- TRUE
paywall_css <- '.dhdsjdh'
paywall_attr <- ''
paywall_multi <- FALSE
tweets_css <- '.twitter > .optinembed'
tweets_attr <- 'data-ctrl-socialmediaembed'
tweets_multi <- TRUE
parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)


# parse info bild
agency <- 'bild'
headline_css <- '.headline'
headline_attr <- ''
headline_multi <- FALSE
headline_intro_css <- '.kicker'
headline_intro_attr <- ''
headline_intro_multi <- FALSE
datetime_css <- 'time'
datetime_attr <- 'datetime'
datetime_multi <- FALSE
domain_css <- '.current, ol li:nth-child(2) a'
domain_attr <- ''
domain_multi <- FALSE
text_intro_css <- '.entry-content, .txt > p:nth-child(1)'
text_intro_attr <- ''
text_intro_multi <- FALSE
text_css <- '.txt > p:nth-child(1n+2)'
text_attr <- ''
text_multi <- TRUE
paywall_css <- 'meta[property=article\\:content_tier]'
paywall_attr <- 'content'
paywall_multi <- FALSE
tweets_css <- '.twitter-tweet > a'
tweets_attr <- 'href'
tweets_multi <- TRUE
parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)

# parse info faz
agency <- 'faz'
headline_css <- '.atc-HeadlineText, .entry-title'
headline_attr <- ''
headline_multi <- FALSE
headline_intro_css <- '.atc-HeadlineEmphasisText, .Stichwort'
headline_intro_attr <- ''
headline_intro_multi <- FALSE
datetime_css <- 'time'
datetime_attr <- 'datetime'
datetime_multi <- FALSE
domain_css <- '.gh-MainNav_SectionsLink-is-active, #BlogTitle'
domain_attr <- ''
domain_multi <- FALSE
text_intro_css <- '.atc-IntroText'
text_intro_attr <- ''
text_intro_multi <- FALSE
text_css <- '.atc-Text > .atc-TextParagraph, .single-entry-content > p'
text_attr <- ''
text_multi <- TRUE
paywall_css <- '.ico-Base_FazPlus'
paywall_attr <- ''
paywall_multi <- FALSE
tweets_css <- ''
tweets_attr <- ''
tweets_multi <- TRUE
parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)

#parse info focus
agency <- 'focus'
headline_css <- '#complain_headline'
headline_attr <- 'value'
headline_multi <- FALSE
headline_intro_css <- '#complain_overhead'
headline_intro_attr <- 'value'
headline_intro_multi <- FALSE
datetime_css <- 'meta[name=date]'
datetime_attr <- 'content'
datetime_multi <- FALSE
domain_css <- '.active'
domain_attr <- ''
domain_multi <- FALSE
text_intro_css <- '.leadIn'
text_intro_attr <- ''
text_intro_multi <- FALSE
text_css <- '.textBlock > p'
text_attr <- ''
text_multi <- TRUE
paywall_css <- '.dhdsjdh'
paywall_attr <- ''
paywall_multi <- FALSE
tweets_css <- '.twitter-tweet > a'
tweets_attr <- 'href'
tweets_multi <- TRUE
parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)

# parse info freitag
agency <- 'freitag'
headline_css <- '.title'
headline_attr <- ''
headline_multi <- FALSE
headline_intro_css <- '.abstract > strong'
headline_intro_attr <- ''
headline_intro_multi <- FALSE
datetime_css <- '.effective-date'
datetime_attr <- ''
datetime_multi <- FALSE
domain_css <- '.active'
domain_attr <- ''
domain_multi <- FALSE
text_intro_css <- '.abstract'
text_intro_attr <- ''
text_intro_multi <- FALSE
text_css <- '.s-article-text > p'
text_attr <- ''
text_multi <- TRUE
paywall_css <- '.gjgxdnknknbklnb'
paywall_attr <- ''
paywall_multi <- FALSE
tweets_css <- '.twitter-tweet > a'
tweets_attr <- 'href'
tweets_multi <- TRUE
parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)

# parse info jungefreiheit
agency <- 'jungefreiheit'
headline_css <- '.entry-title'
headline_attr <- ''
headline_multi <- FALSE
headline_intro_css <- '.jf-subheadline > a'
headline_intro_attr <- ''
headline_intro_multi <- FALSE
datetime_css <- '.entry-time'
datetime_attr <- 'datetime'
datetime_multi <- FALSE
domain_css <- '.breadcrumb-link-wrap:nth-child(1) span'
domain_attr <- ''
domain_multi <- FALSE
text_intro_css <- 'meta[property=og\\:description]'
text_intro_attr <- 'content'
text_intro_multi <- FALSE
text_css <- '.entry-content > p'
text_attr <- ''
text_multi <- TRUE
paywall_css <- '.gjgxdnknknbklnb'
paywall_attr <- ''
paywall_multi <- FALSE
tweets_css <- '.twitter-tweet > p > a'
tweets_attr <- 'href'
tweets_multi <- TRUE
parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)

# parse info spiegel
agency <- 'spiegel'
headline_css <- '.headline, #mainTitle, .opener > h2, .Headline--xl'
headline_attr <- ''
headline_multi <- FALSE
headline_intro_css <- 'span.headline-intro, .o-article__kicker, .opener .category, .Headline--xs'
headline_intro_attr <- ''
headline_intro_multi <- FALSE
datetime_css <- 'meta[property=article\\:published_time], meta[name=last-modified]'
datetime_attr <- 'content'
datetime_multi <- FALSE
domain_css <- '.Navigation-channel, .item-spacing+ .last-item, .active, .a-h3-headline > a, .is-selected > a, .a-label-marker, .current-channel-name, .list-float-left:nth-child(2)'
domain_attr <- ''
domain_multi <- FALSE
text_intro_css <- '.article-intro, .drop, .TeaserIntro--bold:not(.TeaserIntro-author)'
text_intro_attr <- ''
text_intro_multi <- FALSE
text_css <- '.article-section > p, .main-text:not(.drop), .Copy:not(.Copy--serifbold) > p'
text_attr <- ''
text_multi <- TRUE
paywall_css <- '.Paywall'
paywall_attr <- 'data-component'
paywall_multi <- FALSE
tweets_css <- '.twitter-tweet > a'
tweets_attr <- 'href'
tweets_multi <- TRUE
parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)



 # parse info stern
 agency <- 'stern'
 headline_css <- '#mainTitle'
 headline_attr <- 'data-headline'
 headline_multi <- FALSE
 headline_intro_css <- '#mainTitle'
 headline_intro_attr <- 'data-kicker'
 headline_intro_multi <- FALSE
 datetime_css <- 'meta[property=article\\:published_time]'
 datetime_attr <- 'content'
 datetime_multi <- FALSE
 domain_css <- '.is-selected > a, .breadcrumb-title'
 domain_attr <- ''
 domain_multi <- FALSE
 text_intro_css <- '.teaser-article-summary, .article-intro, .leadIn'
 text_intro_attr <- ''
 text_intro_multi <- FALSE
 text_css <- 'div[itemprop=articleBody] > p, .article__body > p'
 text_attr <- ''
 text_multi <- TRUE
 paywall_css <- '.gjgxdnknknbklnb'
 paywall_attr <- ''
 paywall_multi <- FALSE
 tweets_css <- '.twitter-tweet > a'
 tweets_attr <- 'href'
 tweets_multi <- TRUE
 parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)


 # parse info sueddeutsche
 agency <- 'sueddeutsche'
 headline_css <- 'meta[property=og\\:title]'
 headline_attr <- 'content'
 headline_multi <- FALSE
 headline_intro_css <- '.header > h2 > strong'
 headline_intro_attr <- ''
 headline_intro_multi <- FALSE
 datetime_css <- '.timeformat'
 datetime_attr <- 'datetime'
 datetime_multi <- FALSE
 domain_css <- 'body'
 domain_attr <- 'class'
 domain_multi <- FALSE
 text_intro_css <- '.entry-summary, .body ul:not(.article-sidebar-actions)'
 text_intro_attr <- ''
 text_intro_multi <- FALSE
 text_css <- '.body > p:not(.entry-summary)'
 text_attr <- ''
 text_multi <- TRUE
 paywall_css <- '.pay-furtherreading-headline'
 paywall_attr <- ''
 paywall_multi <- FALSE
 tweets_css <- '.twitter-tweet > a'
 tweets_attr <- 'href'
 tweets_multi <- TRUE
 parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)


 # parse info tagesspiegel
 agency <- 'tagesspiegel'
 headline_css <- '.ts-headline'
 headline_attr <- ''
 headline_multi <- FALSE
 headline_intro_css <- '.ts-overline'
 headline_intro_attr <- ''
 headline_intro_multi <- FALSE
 datetime_css <- '.ts-time'
 datetime_attr <- 'datetime'
 datetime_multi <- FALSE
 domain_css <- '.ts-first+ li span'
 domain_attr <- ''
 domain_multi <- FALSE
 text_intro_css <- '.ts-intro'
 text_intro_attr <- ''
 text_intro_multi <- FALSE
 text_css <- '.ts-article-body > p'
 text_attr <- ''
 text_multi <- TRUE
 paywall_css <- '.gjgxdnknknbklnb'
 paywall_attr <- ''
 paywall_multi <- FALSE
 tweets_css <- '.twitter-tweet > a'
 tweets_attr <- 'href'
 tweets_multi <- TRUE
 parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)

 # parse info welt
 agency <- 'welt'
 headline_css <- '.c-headline, .entry-title'
 headline_attr <- ''
 headline_multi <- FALSE
 headline_intro_css <- '.c-topic'
 headline_intro_attr <- ''
 headline_intro_multi <- FALSE
 datetime_css <- 'meta[name=date]'
 datetime_attr <- 'content'
 datetime_multi <- FALSE
 domain_css <- '.c-section'
 domain_attr <- ''
 domain_multi <- FALSE
 text_intro_css <- '.c-summary__intro, .c-summary__headline'
 text_intro_attr <- ''
 text_intro_multi <- FALSE
 text_css <- 'h3 , .__margin-bottom--is-0 p'
 text_attr <- ''
 text_multi <- TRUE
 paywall_css <- '.contains_walled_content'
 paywall_attr <- 'data-external-component'
 paywall_multi <- FALSE
 tweets_css <- '.twitter-tweet > a'
 tweets_attr <- 'href'
 tweets_multi <- TRUE
 parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)

 # parse info zeit
 agency <- 'zeit'
 headline_css <- '.article-heading__title, .article-header__title, .entry-title, .headline__title, .column-heading__title'
 headline_attr <- ''
 headline_multi <- FALSE
 headline_intro_css <- '.article-heading__kicker, .article-header__kicker, .headline__supertitle, .column-heading__kicker'
 headline_intro_attr <- ''
 headline_intro_multi <- FALSE
 datetime_css <- 'meta[name=date], meta[property=article\\:published_time], meta[name=last-modified]'
 datetime_attr <- 'content'
 datetime_multi <- FALSE
 domain_css <- 'meta[property=ligatus\\:section], meta[property=article\\:section]'
 domain_attr <- 'content'
 domain_multi <- FALSE
 text_intro_css <- '.summary, .article__summary, .entry-summary, .entry-content > strong, .header-article__subtitle, .summary'
 text_intro_attr <- ''
 text_intro_multi <- FALSE
 text_css <- '.paragraph, .ph-article-text-body > p, .entry-content >p:not(strong), .article-page > p:not(strong)'
 text_attr <- ''
 text_multi <- TRUE
 paywall_css <- '.paywall'
 paywall_attr <- 'content'
 paywall_multi <- FALSE
 tweets_css <- '.twitter-tweet > a'
 tweets_attr <- 'href'
 tweets_multi <- TRUE
 parser_articles(agency, headline, headline_intro, datetime,domain, text_intro, text, paywall, tweets)
