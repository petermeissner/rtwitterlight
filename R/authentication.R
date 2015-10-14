#' function doing twitter oauth authentication
#' @param key optional key argument; if left as is twitter_token() will first
#'   look if twitterlight_key was set before in the session by
#'   set_twitter_credetnials and thereafter check if it can find the values in
#'   an .Renviron file via sys.getenv("twitterlight_key")
#' @param secret same as key parameter except function will search for
#'   twitterlight_secret
#' @return twitter token used for API interaction by package functions
#'
#'   internal usage: \code{httr::GET(... httr::config( token = twitter_token(key, secret) ) )}
#'   @seealso \link{twl_set_credentials}, \link{Sys.getenv}, \link{oauth_app}, \link{oauth1.0_token}
twl_token <- function(key="", secret=""){
  # get key and secret
  if( key=="" )    key    <- twl_storage$key
  if( secret=="" ) secret <- twl_storage$secret
  if( key=="" )    key <-  Sys.getenv("twitterlight_key")
  if( secret=="" ) secret <- Sys.getenv("twitterlight_secret")
  stopifnot(key!="", secret!="")
  # make app
  myapp <- httr::oauth_app( "twitter", key, secret )
  # get credentials
  twitter_token <- httr::oauth1.0_token(httr::oauth_endpoints("twitter"), myapp)
  # return
  twitter_token
}


#' Package storage for session specific information like credentials
#' @seealso \link{twl_token}, \link{twl_set_credetnials}, \link{twl_reset_credetnials}
twl_storage <- new.env()
twl_storage$key=""
twl_storage$secret=""


#' function storing key and secret for an session
#' @param key key to be used for authentication
#' @param secret secret to be used for authentication
#' @seealso \link{twl_reset_credentials}
twl_set_credentials <- function(key, secret){
  twl_storage$key    <- key
  twl_storage$secret <- secret
}


#' function for resetting credentials set in session storage
#' @seealso \link{twl_set_credentials}
twl_reset_credetnials <- function(){
  twl_set_credentials("","")
}









