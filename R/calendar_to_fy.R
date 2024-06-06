#' Convert calendar dates to financial years
#'
#' @param x \code{vector} of dates
#' @param format \code{character} denoting the date format
#' @return \code{vector} of FYs
#' @author Trent Henderson
#' @examples
#' calendar_to_fy("01/01/97", format = "%d/%m/%Y")
#'

calendar_to_fy <- function(x, format = NULL){
  if(is.null(format)){stop("Date format required.")}
  x <- as.Date(x, format = format)
  m <- as.integer(format(as.Date(x, format = format), "%m"))
  Y <- as.integer(format(as.Date(x, format = format), "%Y"))
  y <- as.integer(format(as.Date(x, format = format), "%y"))
  fy <- paste0(ifelse(m < 7, Y - 1, Y), "-", ifelse(m < 7, y, y + 1))
  return(fy)
}
