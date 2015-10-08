#'
twitter_token <- function(key="", secret=""){
  # get key and secret
  if( key=="" )    key <-  Sys.getenv("rtwitterlight_key")
  if( secret=="" ) secret <- Sys.getenv("rtwitterlight_secret")
  stopifnot(key!="", secret!="")

  # make app
  myapp <- httr::oauth_app( "twitter", key, secret )
  # get credentials
  twitter_token <- httr::oauth1.0_token(oauth_endpoints("twitter"), myapp)
  # return
  twitter_token
}


twitter_api_call <- function(path, parameter){
  # tweet away
  req <-
    httr::POST(
      url  = paste0("https://api.twitter.com/1.1/", path),
      body = parameter,
      config(token = twitter_token()))
  # return
  return(content(req))
}