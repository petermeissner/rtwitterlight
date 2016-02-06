twitter_post <- function(path, param, key="", secret="", token="", token_secret=""){
  # tweet away
  req <-
    httr::POST(
      url  = paste0("https://api.twitter.com/1.1/", path),
      body = param,
      httr::config(token = twitter_token(key, secret, token, token_secret)))
  # return
  return(httr::content(req))
}

twitter_get <- function(path, param, key="", secret="", token="", token_secret=""){
  # tweet away
  req <-
    httr::GET(
      url  = paste0("https://api.twitter.com/1.1/", path),
      query = param,
      httr::config(token = twitter_token(key, secret, token, token_secret)))
  # return
  return(httr::content(req))
}


