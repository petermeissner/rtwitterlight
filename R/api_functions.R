tw_usr_tmln <- function(screen_name, max_id="", count=200, key, secret){
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


tw_user_timeline <- function(screen_name, n=1, key="", secret=""){
  n_loops <- ceiling(n/199)
  tweets  <- list()
  max_id  <- ""
  for(i in seq_len(n_loops) ){
    cat(i, "")
    tweets <-
      c(
        tweets[-200],
        tw_usr_tmln(screen_name, count = 200, max_id = max_id, key, secret)
      )
    max_id_new <- tail(list_get(tweets, "id_str"),1)
    if ( max_id != max_id_new ) {
      max_id <- max_id_new
    }else{
        break()
    }
  }
  return(tweets)
}









