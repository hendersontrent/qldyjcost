#' Pull historical CPI data from the Australian Bureau of Statistics
#'
#' @importFrom readxl read_excel
#' @param location \code{character} denoting which city to pull CPI data for. Can be one of \code{"Australia"}, \code{"Sydney"}, \code{"Melbourne"}, \code{"Brisbane"}, \code{"Adelaide"}, \code{"Perth"}, \code{"Hobart"}, \code{"Darwin"}, \code{"Canberra"}. Defaults to \code{"Australia"}
#' @return \code{data.frame} of results
#' @author Trent Henderson
#' @export
#'

get_cpi <- function(location = c("Australia", "Sydney", "Melbourne", "Brisbane", "Adelaide",
                                 "Perth", "Hobart", "Darwin", "Canberra")){

  match.arg(location)

  # Download and read in Excel file

  url <- "https://www.abs.gov.au/statistics/economy/price-indexes-and-inflation/consumer-price-index-australia/mar-quarter-2024/640101.xlsx"
  temp <- tempfile()
  download.file(url, temp, mode = "wb")
  cpi <- readxl::read_excel(temp, sheet = 2)

  # Clean up data

  cpi <- cpi[, c("...1", paste0("Index Numbers ;  All groups CPI ;  ", location, " ;"))]
  cpi <- cpi[grepl("^\\d{5}$", cpi$...1), ]
  colnames(cpi) <- c("year", "inflation_index")
  cpi$year <- as.Date(as.integer(cpi$year), origin = "1900-01-01")
  cpi$inflation_index <- as.numeric(cpi$inflation_index)

  # Add financial years

  cpi$fy <- calendar_to_fy(cpi$year, format = "%Y-%m-%d")
  cpi <- structure(cpi, class = c("cpi", "data.frame"))
  return(cpi)
}
