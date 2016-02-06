#' function doing twitter oauth authentication
#' @param key optional key argument; if left as is twitter_token() will first
#'   look if twitterlight_key was set before in the session by
#'   set_twitter_credetnials and thereafter check if it can find the values in
#'   an .Renviron file via sys.getenv("twitterlight_key")
#' @param secret same as key parameter except function will search for
#'   twitterlight_secret
#' @param token for headless mode, in normal mode token will be fetched and
#'    permissions checked interactively by user; if interaction is impossible
#'    token can be supplied manually
#' @param token_secret for headless mode, in normal mode token will be fetched and
#'    permissions checked interactively by user; if interaction is impossible
#'    token can be supplied manually
#' @return twitter token used for API interaction by package functions
#'
#'   internal usage: \code{httr::GET(... httr::config( token = twitter_token(key, secret) ) )}
#'   @seealso \link{twl_set_credentials}, \link{Sys.getenv}, \link{oauth_app}, \link{oauth1.0_token}
twitter_token <- function(key="", secret="", token="", token_secret=""){
  # get key and secret
  if( key=="" )    key    <- twl_storage$key
  if( secret=="" ) secret <- twl_storage$secret
  if( key=="" )    key <-  Sys.getenv("twitterlight_key")
  if( secret=="" ) secret <- Sys.getenv("twitterlight_secret")
  stopifnot(key!="", secret!="")
  # make app
  myapp <- httr::oauth_app( "twitter", key, secret )
  if( token=="" | token_secret==""){
    # get credentials - normal mode
    twitter_token <- httr::oauth1.0_token(httr::oauth_endpoints("twitter"), myapp)
  }else{
    # get credentials - headless mode
    twitter_token <-
      httr::Token1.0$new(
        endpoint      = NULL,
        params        = list(as_header = TRUE),
        app           = myapp,
        credentials   = list(
          oauth_token        = token,
          oauth_token_secret = token_secret
        )
      )
  }
  # return
  return(twitter_token)
}


#' Package storage for session specific information like credentials
#' @seealso \link{twl_token}, \link{twl_set_credetnials}, \link{twl_reset_credetnials}
twl_storage <- new.env()
twl_storage$key          <- ""
twl_storage$secret       <- ""
twl_storage$token        <- ""
twl_storage$token_secret <- ""


#' function storing key and secret for an session
#' @param key key to be used for authentication
#' @param secret secret to be used for authentication
#' @seealso \link{twl_reset_credentials}
twl_set_credentials <- function(key="", secret="", token="", token_secret=""){
  twl_storage$key          <- key
  twl_storage$secret       <- secret
  twl_storage$token        <- token
  twl_storage$token_secret <- token_secret
}


#' function for resetting credentials set in session storage
#' @seealso \link{twl_set_credentials}
twl_reset_credentials <- function(){
  twl_set_credentials(key="", secret="", token="", token_secret="")
}









