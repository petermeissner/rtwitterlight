twitter_post <- function(path, param){
  # tweet away
  req <-
    httr::POST(
      url  = paste0("https://api.twitter.com/1.1/", path),
      body = param,
      config(token = twitter_token()))
  # return
  return(httr::content(req))
}

twitter_get <- function(path, param){
  # tweet away
  req <-
    httr::GET(
      url  = paste0("https://api.twitter.com/1.1/", path),
      query = param,
      httr::config(token = twitter_token()))
  # return
  return(httr::content(req))
}


