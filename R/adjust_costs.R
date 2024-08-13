#' Adjust YJ costs to a given financial year using CPI
#'
#' @param fy \code{character} denoting the financial year to adjust to. Must be of the format \code{"YYYY-YY"}. Defaults to \code{NULL}
#' @param location \code{character} denoting which city to pull CPI data for. Can be one of \code{"Australia"}, \code{"Sydney"}, \code{"Melbourne"}, \code{"Brisbane"}, \code{"Adelaide"}, \code{"Perth"}, \code{"Hobart"}, \code{"Darwin"}, \code{"Canberra"}. Defaults to \code{"Australia"}
#' @param ... arguments to be passed to \code{avg_cpi}
#' @return \code{data.frame} of adjusted costs and associated information
#' @author Trent Henderson
#' @export
#'

adjust_costs <- function(fy = NULL,
                         location = c("Australia", "Sydney", "Melbourne", "Brisbane", "Adelaide",
                                      "Perth", "Hobart", "Darwin", "Canberra"), ...){
  stopifnot(!is.null(fy))
  stopifnot(grepl("^\\d{4}-\\d{2}$", fy))
  location <- match.arg(location)
  cpi <- get_cpi(location = location)
  adj <- qldyjcost::yjcosts
  adj$new_fy <- fy
  adj$avg_cpi_old <- avg_cpi(cpi, adj$fy, ...)
  adj$avg_cpi_new <- avg_cpi(cpi, adj$new_fy, ...)
  adj$new_cost <- adj$cost + (adj$cost * ((adj$avg_cpi_new / adj$avg_cpi_old) - 1))
  return(adj)
}
