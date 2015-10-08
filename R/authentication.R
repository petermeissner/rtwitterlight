#'
twitter_token <- function(key="", secret=""){
  # get key and secret
  if( key=="" )    key <-  Sys.getenv("rtwitterlight_key")
  if( secret=="" ) secret <- Sys.getenv("rtwitterlight_secret")
  stopifnot(key!="", secret!="")

  # make app
  myapp <- httr::oauth_app( "twitter", key, secret )
  # get credentials
  twitter_token <- httr::oauth1.0_token(httr::oauth_endpoints("twitter"), myapp)
  # return
  twitter_token
}














