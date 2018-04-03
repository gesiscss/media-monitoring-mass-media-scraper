#!/usr/local/bin/Rscript
setwd("/Users/ehnertpp/newspaper-scraping-germany")

#Entfernte Feeds
#abendblatt
#list("url" = "http://www.abendblatt.de/?service=Rss", "agency" = "abendblatt", "kategorie" = "home"),
#list("url" = "http://www.abendblatt.de/hamburg/?service=Rss", "agency" = "abendblatt", "kategorie" = "hamburg"),
#list("url" = "http://www.abendblatt.de/sport/?service=Rss", "agency" = "abendblatt", "kategorie" = "sport"),
#list("url" = "http://www.abendblatt.de/politik/?service=Rss","agency" = "abendblatt", "kategorie" = "politik"),
#list("url" = "http://www.abendblatt.de/wirtschaft/?service=Rss","agency" = "abendblatt", "kategorie" = "wirtschaft"),
#list("url" = "http://www.abendblatt.de/vermischtes/?service=Rss","agency" =  "abendblatt", "kategorie" = "vermischtes"),
#list("url" = "http://www.abendblatt.de/kultur-live/tv-und-medien/?service=Rss","agency" =  "abendblatt", "kategorie" = "kultur-live"),
#Bild
#list("url" = "https://www.bild.de/rssfeeds/vw-sport/vw-sport-16729856,dzbildplus=true,short=1,sort=1,teaserbildmobil=false,view=rss2.bild.xml","agency" =  "bild", "kategorie" = "sport"),
#FAZ
#list("url" = "http://www.faz.net/rss/aktuell/gesellschaft/", "agency" =  "faz", "kategorie" = "gesellschaft"),
#FOCUS
#list("url" = "http://rss.focus.de/gesundheit/news/", "agency" =  "focus", "kategorie" = "gesundheit"),
#list("url" = "http://rss.focus.de/kultur/vermischtes/", "agency" =  "focus", "kategorie" = "vermischtes"),
#list("url" = "http://rss.focus.de/panorama/", "agency" =  "focus", "kategorie" = "panorama"),
#list("url" = "http://rss.focus.de/digital/", "agency" =  "focus", "kategorie" = "digital"),
#list("url" = "http://www.focus.de/fol/XML/rss_folnews.xml", "agency" =  "focus", "kategorie" = "home"),
#GMX
#list("url" = "https://www.gmx.net/feeds/rss/magazine/index.rss", "agency" =  "gmx", "kategorie" = "magazin"),
#list("url" = "https://www.gmx.net/magazine/lifestyle/index.rss", "agency" =  "gmx", "kategorie" = "lifestyle"),
#list("url" = "https://www.gmx.net/magazine/unterhaltung/index.rss", "agency" =  "gmx", "kategorie" = "unterhaltung"),
#list("url" = "https://www.gmx.net/magazine/auto/index.rss", "agency" =  "gmx", "kategorie" = "auto"),
#list("url" = "https://www.gmx.net/magazine/gesundheit/index.rss", "agency" =  "gmx", "kategorie" = "gesundheit"),
#list("url" = "https://www.gmx.net/magazine/tv/index.rss", "agency" =  "gmx", "kategorie" = "tv"),
#list("url" = "https://www.gmx.net/magazine/digitale-welt/index.rss", "agency" =  "gmx", "kategorie" = "digitale-welt"),
#list("url" = "https://www.gmx.net/magazine/wissen/index.rss", "agency" =  "gmx", "kategorie" = "wissen"),
#list("url" = "https://www.gmx.net/magazine/reise/index.rss", "agency" =  "gmx", "kategorie" = "reise"),
#Handelsblatt
#list("url" = "http://www.handelsblatt.com/contentexport/feed/schlagzeilen", "agency" =  "handelsblatt", "kategorie" = "schlagzeilen"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/wirtschaft", "agency" =  "handelsblatt", "kategorie" = "wirtschaft"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/top-themen", "agency" =  "handelsblatt", "kategorie" = "topthemen"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/finanzen", "agency" =  "handelsblatt", "kategorie" = "finanzen"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/marktberichte", "agency" =  "handelsblatt", "kategorie" = "marktberichte"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/unternehmen", "agency" =  "handelsblatt", "kategorie" = "unternehmen"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/politik", "agency" =  "handelsblatt", "kategorie" = "politik"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/technologie", "agency" =  "handelsblatt", "kategorie" = "technologie"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/panorama", "agency" =  "handelsblatt", "kategorie" = "panorama"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/sport", "agency" =  "handelsblatt", "kategorie" = "sport"),
#list("url" = "http://www.handelsblatt.com/contentexport/feed/hbfussball", "agency" =  "handelsblatt", "kategorie" = "hbfussball"),
#Spiegel
#list("url" = "http://www.spiegel.de/panorama/index.rss", "agency" =  "spiegel", "kategorie" = "panorama"),
#list("url" = "http://www.spiegel.de/wissenschaft/index.rss", "agency" =  "spiegel", "kategorie" = "wissenschaft"),
#list("url" = "http://www.spiegel.de/gesundheit/index.rss", "agency" =  "spiegel", "kategorie" = "gesundheit"),
#list("url" = "http://www.spiegel.de/karriere/index.rss", "agency" =  "spiegel", "kategorie" = "karriere"),
#list("url" = "http://www.spiegel.de/reise/index.rss", "agency" =  "spiegel", "kategorie" = "reise"),
#list("url" = "http://www.spiegel.de/auto/index.rss", "agency" =  "spiegel", "kategorie" = "auto"),
#list("url" = "http://www.spiegel.de/einestages/index.rss", "agency" =  "spiegel", "kategorie" = "einestages"),
#Stuttgarter Zeitung
#list("url" = "http://www.stuttgarter-zeitung.de/news.rss.feed", "agency" =  "stuttgarter", "kategorie" = "home"), 
#tagesspiegel
#list("url" = "http://www.tagesspiegel.de/contentexport/feed/berlin", "agency" =  "tagesspiegel", "kategorie" = "berlin"), 
#list("url" = "http://www.tagesspiegel.de/contentexport/feed/queerspiegel", "agency" =  "tagesspiegel", "kategorie" = "queerspiegel"), 
#list("url" = "http://www.tagesspiegel.de/contentexport/feed/kultur", "agency" =  "tagesspiegel", "kategorie" = "kultur"), 
#list("url" = "http://www.tagesspiegel.de/contentexport/feed/medien", "agency" =  "tagesspiegel", "kategorie" = "medien"), 
#list("url" = "http://www.tagesspiegel.de/contentexport/feed/wissen", "agency" =  "tagesspiegel", "kategorie" = "wissen"), 
#tonline
#list("url" = "http://feeds.t-online.de/rss/boulevard", "agency" =  "tonline", "kategorie" = "boulevard"),
#list("url" = "http://feeds.t-online.de/rss/buntes-und-kurioses", "agency" =  "tonline", "kategorie" = "buntes-und-kurioses"),
#list("url" = "http://feeds.t-online.de/rss/tiere", "agency" =  "tonline", "kategorie" = "tiere"),
#list("url" = "http://feeds.t-online.de/rss/wissenschaft-und-forschung", "agency" =  "tonline", "kategorie" = "wissenschaft-und-forschung"),
#list("url" = "http://feeds.t-online.de/rss/digital", "agency" =  "tonline", "kategorie" = "digital"),
#list("url" = "http://feeds.t-online.de/rss/auto", "agency" =  "tonline", "kategorie" = "auto"),
#list("url" = "http://feeds.t-online.de/rss/unterhaltung", "agency" =  "tonline", "kategorie" = "unterhaltung"),
#list("url" = "http://feeds.t-online.de/rss/lifestyle", "agency" =  "tonline", "kategorie" = "lifestyle"),
#list("url" = "http://feeds.t-online.de/rss/spiele", "agency" =  "tonline", "kategorie" = "spiele"),
#list("url" = "http://feeds.t-online.de/rss/handy", "agency" =  "tonline", "kategorie" = "handy"),
#list("url" = "http://feeds.t-online.de/rss/reisen", "agency" =  "tonline", "kategorie" = "reisen"),
#Webde
#list("url" = "https://web.de/magazine/lifestyle/index.rss", "agency" =  "webde", "kategorie" = "lifestyle"),
#list("url" = "https://web.de/magazine/unterhaltung/index.rss", "agency" =  "webde", "kategorie" = "unterhaltung"),
#list("url" = "https://web.de/magazine/auto/index.rss", "agency" =  "webde", "kategorie" = "auto"),
#list("url" = "https://web.de/magazine/gesundheit/index.rss", "agency" =  "webde", "kategorie" = "gesundheit"),
#list("url" = "https://web.de/magazine/tv/index.rss", "agency" =  "webde", "kategorie" = "tv"),
#list("url" = "https://web.de/magazine/digitale-welt/index.rss", "agency" =  "webde", "kategorie" = "digitale-welt"),
#list("url" = "https://web.de/magazine/wissen/index.rss", "agency" =  "webde", "kategorie" = "wissen"),
#list("url" = "https://web.de/magazine/reise/index.rss", "agency" =  "webde", "kategorie" = "reise"),
#Welt
#list("url" = "https://www.welt.de/feeds/section/kultur.rss", "agency" =  "welt", "kategorie" = "kultur"),
#list("url" = "https://www.welt.de/feeds/section/icon.rss", "agency" =  "welt", "kategorie" = "icon"),
#list("url" = "https://www.welt.de/feeds/section/gesundheit.rss", "agency" =  "welt", "kategorie" = "gesundheit"),
#list("url" = "https://www.welt.de/feeds/section/motor.rss", "agency" =  "welt", "kategorie" = "motor"),
#list("url" = "https://www.welt.de/feeds/section/reise.rss", "agency" =  "welt", "kategorie" = "reise"),
#yahoode
#list("url" = "https://de.style.yahoo.com/rss", "agency" =  "yahoode", "kategorie" = "style"),
#Zeit
#list("url" = "http://newsfeed.zeit.de/kultur/index", "agency" =  "zeit", "kategorie" = "kultur"),
#list("url" = "http://newsfeed.zeit.de/wissen/index", "agency" =  "zeit", "kategorie" = "wissen"),
#list("url" = "http://newsfeed.zeit.de/entdecken/index", "agency" =  "zeit", "kategorie" = "entdecken"),
#list("url" = "http://newsfeed.zeit.de/mobilitaet/index", "agency" =  "zeit", "kategorie" = "mobilit?t"),

rss_feeds <- list(
  #ARD
  list("url" = "http://www.tagesschau.de/xml/rss2", "agency" = "ard", "kategorie" = "home"),
  list("url" = "http://www.sportschau.de/sportschauindex100_type-rss.feed", "agency" = "ard", "kategorie" = "sport"),
  #Bild
  list("url" = "http://www.bild.de/rssfeeds/vw-home/vw-home-16725562,sort=1,view=rss2.bild.xml", "agency" = "bild", "kategorie" = "home"),
  list("url" = "http://www.bild.de/rssfeeds/vw-politik/vw-politik-16728980,sort=1,view=rss2.bild.xml","agency" =  "bild", "kategorie" = "politik"),
  list("url" = "http://www.bild.de/rssfeeds/vw-news/vw-news-16726644,sort=1,view=rss2.bild.xml", "agency" = "bild", "kategorie" = "news"),
  #FAZ
  list("url" = "http://www.faz.net/rss/aktuell/", "agency" =  "faz", "kategorie" = "home"),
  list("url" = "http://www.faz.net/rss/aktuell/politik/", "agency" =  "faz", "kategorie" = "politik"),
  list("url" = "http://www.faz.net/rss/aktuell/politik/europaeische-union/", "agency" =  "faz", "kategorie" = "politikeu"),
  list("url" = "http://www.faz.net/rss/aktuell/politik/ausland/", "agency" =  "faz", "kategorie" = "politikausland"),
  list("url" = "http://www.faz.net/rss/aktuell/wirtschaft/", "agency" =  "faz", "kategorie" = "wirtschaft"),
  list("url" = "http://www.faz.net/rss/aktuell/sport/", "agency" =  "faz", "kategorie" = "sport"),
  #FOCUS
  list("url" = "http://rss.focus.de/politik/", "agency" =  "focus", "kategorie" = "politik"),
  list("url" = "http://rss.focus.de/politik/ausland/", "agency" =  "focus", "kategorie" = "politikausland"),
  list("url" = "http://rss.focus.de/finanzen/", "agency" =  "focus", "kategorie" = "finanzen"),
  list("url" = "http://rss.focus.de/sport/", "agency" =  "focus", "kategorie" = "sport"),
  #Freitag
  list("url" = "https://www.freitag.de/@@RSS", "agency" =  "freitag", "kategorie" = "home"),
  list("url" = "https://www.freitag.de/politik/@@RSS", "agency" =  "freitag", "kategorie" = "politik"),
  #GMX
  list("url" = "https://www.gmx.net/magazine/nachrichten/index.rss", "agency" =  "gmx", "kategorie" = "nachrichten"),
  list("url" = "https://www.gmx.net/magazine/finanzen/index.rss", "agency" =  "gmx", "kategorie" = "finanzen"),
  list("url" = "https://www.gmx.net/magazine/sport/index.rss", "agency" =  "gmx", "kategorie" = "sport"),
  #jungefreiheit
  list("url" = "https://jungefreiheit.de/feed/", "agency" =  "jungefreiheit", "kategorie" = "home"),
  #NTV
  list("url" = "https://www.n-tv.de/rss", "agency" =  "ntv", "kategorie" = "home"),
  list("url" = "https://www.n-tv.de/wirtschaft/rss", "agency" =  "ntv", "kategorie" = "wirtschaft"),
  #Spiegel
  list("url" = "http://www.spiegel.de/schlagzeilen/tops/index.rss", "agency" =  "spiegel", "kategorie" = "tops"),
  list("url" = "http://www.spiegel.de/schlagzeilen/index.rss", "agency" =  "spiegel", "kategorie" = "home"),
  list("url" = "http://www.spiegel.de/politik/index.rss", "agency" =  "spiegel", "kategorie" = "politik"),
  list("url" = "http://www.spiegel.de/wirtschaft/index.rss", "agency" =  "spiegel", "kategorie" = "wirtschaft"),
  list("url" = "http://www.spiegel.de/sport/index.rss", "agency" =  "spiegel", "kategorie" = "sport"),
  list("url" = "http://www.spiegel.de/kultur/index.rss", "agency" =  "spiegel", "kategorie" = "kultur"),
  list("url" = "http://www.spiegel.de/netzwelt/index.rss", "agency" =  "spiegel", "kategorie" = "netzwelt"),
  #Stern
  list("url" = "https://www.stern.de/feed/standard/alle-nachrichten/", "agency" =  "stern", "kategorie" = "nachrichten"),
  list("url" = "https://www.stern.de/feed/standard/all/", "agency" =  "stern", "kategorie" = "home"),
  list("url" = "https://www.stern.de/feed/standard/politik/", "agency" =  "stern", "kategorie" = "politik"),
  list("url" = "https://www.stern.de/feed/standard/panorama/", "agency" =  "stern", "kategorie" = "panorama"),
  list("url" = "https://www.stern.de/feed/standard/sport/", "agency" =  "stern", "kategorie" = "sport"),
  list("url" = "https://www.stern.de/feed/standard/wirtschaft/", "agency" =  "stern", "kategorie" = "wirtschaft"),
  #sueddeutsche
  list("url" = "http://www.sueddeutsche.de/news/rss?search=&sort=date&all%5B%5D=dep&typ%5B%5D=article&sys%5B%5D=sz&catsz%5B%5D=alles&time=P30D", "agency" =  "sueddeutsche", "kategorie" = "home"), 
  #tagesspiegel
  list("url" = "http://www.tagesspiegel.de/contentexport/feed/home", "agency" =  "tagesspiegel", "kategorie" = "home"), 
  list("url" = "http://www.tagesspiegel.de/contentexport/feed/politik", "agency" =  "tagesspiegel", "kategorie" = "politik"), 
  list("url" = "http://www.tagesspiegel.de/contentexport/feed/wirtschaft", "agency" =  "tagesspiegel", "kategorie" = "wirtschaft"), 
  list("url" = "http://www.tagesspiegel.de/contentexport/feed/sport", "agency" =  "tagesspiegel", "kategorie" = "sport"), 
  list("url" = "http://www.tagesspiegel.de/contentexport/feed/weltspiegel", "agency" =  "tagesspiegel", "kategorie" = "weltspiegel"), 
  list("url" = "http://www.tagesspiegel.de/contentexport/feed/meinung", "agency" =  "tagesspiegel", "kategorie" = "meinung"), 
  #tonline
  list("url" = "http://feeds.t-online.de/rss/nachrichten", "agency" =  "tonline", "kategorie" = "nachrichten"),
  list("url" = "http://feeds.t-online.de/rss/deutschland", "agency" =  "tonline", "kategorie" = "deutschland"),
  list("url" = "http://feeds.t-online.de/rss/ausland", "agency" =  "tonline", "kategorie" = "ausland"),
  list("url" = "http://feeds.t-online.de/rss/panorama", "agency" =  "tonline", "kategorie" = "panorama"),
  list("url" = "http://feeds.t-online.de/rss/politik", "agency" =  "tonline", "kategorie" = "politik"),
  list("url" = "http://feeds.t-online.de/rss/parteien", "agency" =  "tonline", "kategorie" = "parteien"),
  list("url" = "http://feeds.t-online.de/rss/katastrophen-und-ungluecke", "agency" =  "tonline", "kategorie" = "katastrophen-und-ungl?cke"),
  list("url" = "http://feeds.t-online.de/rss/kriminalitaet", "agency" =  "tonline", "kategorie" = "kriminalit?t"),
  list("url" = "http://feeds.t-online.de/rss/klimawandel", "agency" =  "tonline", "kategorie" = "klimawandel"),
  list("url" = "http://feeds.t-online.de/rss/wirtschaft",  "agency" =  "tonline", "kategorie" = "wirtschaft"),
  list("url" = "http://feeds.t-online.de/rss/sport", "agency" =  "tonline", "kategorie" = "sport"),
  list("url" = "http://feeds.t-online.de/rss/fussball", "agency" =  "tonline", "kategorie" = "fussball"),
  #Webde
  list("url" = "https://web.de/magazine/index.rss", "agency" =  "webde", "kategorie" = "home"),
  list("url" = "https://web.de/magazine/nachrichten/index.rss", "agency" =  "webde", "kategorie" = "nachrichten"),
  list("url" = "https://web.de/magazine/finanzen/index.rss", "agency" =  "webde", "kategorie" = "finanzen"),
  list("url" = "https://web.de/magazine/sport/index.rss", "agency" =  "webde", "kategorie" = "sport"),
  #Welt
  list("url" = "https://www.welt.de/feeds/topnews.rss", "agency" =  "welt", "kategorie" = "topnews"),
  list("url" = "https://www.welt.de/feeds/section/politik.rss", "agency" =  "welt", "kategorie" = "politik"),
  list("url" = "https://www.welt.de/feeds/section/wirtschaft.rss", "agency" =  "welt", "kategorie" = "wirtschaft"),
  list("url" = "https://www.welt.de/feeds/section/finanzen.rss", "agency" =  "welt", "kategorie" = "finanzen"),
  list("url" = "https://www.welt.de/feeds/section/wirtschaft/webwelt.rss", "agency" =  "welt", "kategorie" = "webwelt"),
  list("url" = "https://www.welt.de/feeds/section/sport.rss", "agency" =  "welt", "kategorie" = "sport"),
  list("url" = "https://www.welt.de/feeds/section/vermischtes.rss", "agency" =  "welt", "kategorie" = "vermischtes"),
  list("url" = "https://www.welt.de/feeds/section/debatte.rss", "agency" =  "welt", "kategorie" = "debatte"),
  #yahoode
  list("url" = "https://de.nachrichten.yahoo.com/rss", "agency" =  "yahoode", "kategorie" = "nachrichten"),
  list("url" = "https://de.sports.yahoo.com/rss/", "agency" =  "yahoode", "kategorie" = "sport"),
  #Zeit
  list("url" = "http://newsfeed.zeit.de/index", "agency" =  "zeit", "kategorie" = "home"),
  list("url" = "http://newsfeed.zeit.de/politik/index", "agency" =  "zeit", "kategorie" = "politik"),
  list("url" = "http://newsfeed.zeit.de/wirtschaft/index", "agency" =  "zeit", "kategorie" = "wirtschaft"),
  list("url" = "http://newsfeed.zeit.de/gesellschaft/index", "agency" =  "zeit", "kategorie" = "gesellschaft"),
  list("url" = "http://newsfeed.zeit.de/digital/index", "agency" =  "zeit", "kategorie" = "digital"),
  list("url" = "http://newsfeed.zeit.de/sport/index", "agency" =  "zeit", "kategorie" = "sport"),
  list("url" = "http://newsfeed.zeit.de/all", "agency" =  "zeit", "kategorie" = "all")
  )

#list of patterns: ?service=Rss | @@RSS | index.rss | /index.rss$
scraper_headlines <- function(folder, rss_feeds, agency) {
  # load packages
  require(stringr)
  require(magrittr)
  require(xml2)
  require(rvest)
  rss_out_list <- lapply(rss_feeds, read_xml)
  # write raw RSS
  dir.create(folder, showWarnings = FALSE, recursive = TRUE)
  datetime <- format(as.POSIXct(Sys.time(), tz = Sys.timezone()), usetz = TRUE)  %>% as.character() %>% str_replace_all("[ :]", "-")
  rss_feeds <- rss_feeds %>% str_replace("@@RSS|\\/index.rss\\$|index.rss|\\/index|\\/rss", "")
  filepaths <-paste0(folder, "/", agency, "-", datetime, "-", basename(rss_feeds), ".rss")
  
  #Ausnahme von Malte nochmal ?berpr?fen lassen ob es nicht eleganter geht :)
  
  if (agency == "sueddeutsche")
  {
    url_out <- read_xml("http://www.sueddeutsche.de/news/rss?search=&sort=date&all%5B%5D=dep&typ%5B%5D=article&sys%5B%5D=sz&catsz%5B%5D=alles&time=P30D")
    write_xml(url_out, file = paste0(folder, "/sueddeutsche-", datetime, ".rss"), options = "format")
  }
  else
  {
    Map(function(x, filepath) write_xml(x, file = filepath, w, options = "format"), rss_out_list, filepaths)
  }
  
}


scraper_articles <- function(folderInput, folderOutput, agency) {
  # load packages
  require(httr)
  require(rvest)
  require(stringr)
  require(magrittr)
  require(R.utils)
  # import xmls
  filename <- paste0(agency, ".+rss$") 
  xmls <- list.files(folderInput, pattern = filename, full.names = TRUE)
  if (length(xmls) > 1)
  { xmls <- xmls[(length(xmls)-(length(rss_feeds)-1)):length(xmls)] }# pick only newest files}
  xmls_parsed <- lapply(xmls, read_xml)
  urls_parsed <- lapply(xmls_parsed, function(x) { xml_nodes(x, "link") %>% xml_text %>% str_replace("bild.html\\$|\\?source=rss|\\?src=rss|\\#ref=rss|\\?utm_campaign(.*)|/index$", "")}) %>% unlist %>% unique()
  # download article htmls
  dir.create(folderOutput, showWarnings = FALSE, recursive = TRUE)
  urls_articles <- urls_parsed %>% unlist 
  sapply(urls_articles, function(x){
    destfile <- paste0(folderOutput, "/", agency, "-", basename(x))
    test <- grepl(".html", destfile)
    if (test == FALSE)
    {
      destfile <- paste0(destfile, ".html")
      
    }
    if(!file.exists(destfile)) {
      withTimeout({try(download.file(x, destfile = destfile, method = "libcurl"))},
                  timeout = 10,
                  onTimeout = "silent")
    }
  })
}