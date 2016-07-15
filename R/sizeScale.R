#' @title markerSizeScale
#'
#' @description Internal function to scale marker sizes
#
#' @param size size vector
#' @param maxScale max size of marker (in px)
#'
#' @return
#' Returns a vector which has been scaled between 5 and maxScale
markerSizeScale <- function(size, maxScale = 20){

  if(!is.numeric(size)) stop("Size vector is not numeric !")

  x <- size - min(size)
  x <- x/max(x)
  x <- x * maxScale + 5

  # If only one size is specified
  # As opposed to a vector of values
  if(is.nan(x)) {
    return(size)
  }else{
    return(x)
  }
}
