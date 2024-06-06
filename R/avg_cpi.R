#' Calculate an average CPI over a given FY
#'
#' @param cpi \code{cpi} object containing the inflation rates as returned by \code{get_cpi}
#' @param fy \code{character} denoting the financial year to calculate the average over. Must be of the format \code{"YYYY-YY"}. Defaults to \code{NULL}
#' @param ... arguments to be passed to \code{mean}
#' @return \code{numeric} scalar of the average inflation over the FY
#' @author Trent Henderson
#'

avg_cpi <- function(cpi, fy = NULL, ...){
  stopifnot(inherits(cpi, "cpi") == TRUE)
  stopifnot(!is.null(fy))
  stopifnot(grepl("^\\d{4}-\\d{2}$", fy))

  avg <- sapply(fy, function(f) {
    mean(cpi[cpi$fy == f, "inflation_index"], ...)
  })

  avg <- as.vector(avg)
  return(avg)
}
