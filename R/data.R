#' Core YJ cost data with values from original sources
#'
#' The variables include:
#'
#' @format A tidy data frame with 5 variables:
#' \describe{
#'   \item{qasoc_code}{QASOC code for the offence}
#'   \item{qasoc_description}{Offence type description}
#'   \item{type}{Type of cost the value pertains to. Is one of Court, Police, Wider social, or Custody}
#'   \item{cost}{Numerical value of the offence}
#'   \item{fy}{Financial year the cost pertains to}
#' }
#'
#' @references Allard T, McCarthy M & Stewart A 2020. The costs of Indigenous and non-Indigenous offender trajectories. Trends & issues in crime and criminal justice no. 594. Canberra: Australian Institute of Criminology. https://doi.org/10.52922/ti04329
#' @references Allard, T., Stewart, A., Smith, C., Dennison, S., Chrzanowski, A., & Thompson, C. (2014). The monetary cost of offender trajectories: Findings from Queensland (Australia). Australian & New Zealand Journal of Criminology, 47(1), 81-101. https://doi.org/10.1177/0004865813503350
#' @references Australian Government. 2022. Report on Government Services 2022. https://www.pc.gov.au/ongoing/report-on-government-services/2022/community-services/youth-justice
#'
"yjcosts"
