#' Prices of 50,000 round cut diamonds
#'
#' A dataset containing the prices and other attributes of almost 54,000
#'  diamonds. The variables are as follows:
#'
#' @format A data frame with 53940 rows and 10 variables:
#' \itemize{
#'   \item price: price in US dollars (\$326--\$18,823)
#'   \item carat: weight of the diamond (0.2--5.01)
#'   \item cut: quality of the cut (Fair, Good, Very Good, Premium, Ideal)
#'   \item color: diamond colour, from J (worst) to D (best)
#'   \item clarity: a measurement of how clear the diamond is
#'      (I1 (worst), SI1, SI2, VS1, VS2, VVS1, VVS2, IF (best))
#'   \item x: length in mm (0--10.74)
#'   \item y: width in mm (0--58.9)
#'   \item z: depth in mm (0--31.8)
#'   \item depth: total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43--79)
#'   \item table: width of top of diamond relative to widest point (43--95)
#' }
"diamonds"

#' Education statistics
#'
#' A dataset containing statistics related to literacy rates for various countries
#' across different years.
#'
#' @format A data frame with 3630 rows and 6 variables:
#' \itemize{
#' \item Country: Country of observation
#' \item Year: Year (2010 - 2014)
#' \item Adult.literacy.rate: Percentage of population age 15 and above who can read and write
#' divided by the corresponding age group population multiplied by 100.
#' \item GDP.at.market.prices: GDP in constant 2005 U.S. dollars.
#' \item Government.education.expenditure: Total general (local, regional and central)
#' government expenditure on education expressed as a percentage of total general government
#' expenditure.
#' \item Youth.literacy.rate: Number of people age 15 to 24 years who can both read and write
#' divided by the total population in the same age group multiplied by 100.
#'}
#' @source \url{http://data.worldbank.org/data-catalog/ed-stats}
"WorldEducationIndicators"
