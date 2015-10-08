tw_user_timeline <- function(screen_name, max_id="", count=200){
  param= list(
    screen_name = screen_name,
    count = count
  )
  if( max_id != ""){
    param$max_id <- max_id
  }
  twitter_get(
    path="statuses/user_timeline.json",
    param = param
  )
}
