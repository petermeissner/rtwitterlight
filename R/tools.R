#' function for extracting thing from list
list_get <- function(x, feature){
  unlist(lapply(x, '[[', feature))
}
