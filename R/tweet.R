#' function for tweeting
tweet <- function(tweet){
  stopifnot( length(tweet)[1]==1 )

  # tweet away
  req <-
    twitter_post(
      path  = "statuses/update.json",
      param = list(status=tweet)
    )

  # return
  return(req)
}
