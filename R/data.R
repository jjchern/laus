#' @title State by year level US employment data
#'
#' @description Annual averages series of employment status of the civilian noninstitutional population from BLS.
#'
#' @format A data frame with ten variables:
#' * `fips` = "FIPS code",
#' * `state` = "State or area",
#' * `year` = "Year",
#' * `pop` = "Civilian non-institutional population",
#' * `clf` = "Total numer of people in civilian labor force",
#' * `pc_clf` = "Labor force participation rate (= labor force / population; Age: 16 years and over)",
#' * `emp` = "The number of people employed",
#' * `pc_emp` = "Employment-population ratio (= employment / population; Age: 16 years and over)",
#' * `unem` = "The number of people unemployed",
#' * `unem_rate` = "Unemployment rate (= unemployment / labor force; Age: 16 years and over)"
#'
#' @source [http://www.bls.gov/lau/rdscnp16.htm]()
"state_year"

#' @title State by month level US employment data
#'
#' @description Monthly series (seasonly adjusted) of employment status of the civilian noninstitutional population from BLS.
#'
#' @format A data frame with ten variables:
#' * `fips` = "FIPS code",
#' * `state` = "State or area",
#' * `year` = "Year",
#' * `month` = "Month",
#' * `pop` = "Civilian non-institutional population",
#' * `clf` = "Total numer of people in civilian labor force",
#' * `pc_clf` = "Labor force participation rate (= labor force / population; Age: 16 years and over)",
#' * `emp` = "The number of people employed",
#' * `pc_emp` = "Employment-population ratio (= employment / population; Age: 16 years and over)",
#' * `unem` = "The number of people unemployed",
#' * `unem_rate` = "Unemployment rate (= unemployment / labor force; Age: 16 years and over)"
#'
#' @source [http://www.bls.gov/lau/rdscnp16.htm]()
"state_month_sa"

#' @title State by month level US employment data
#'
#' @description Monthly series (not seasonly adjusted) of employment status of the civilian noninstitutional population from BLS.
#'
#' @format A data frame with ten variables:
#' * `fips` = "FIPS code",
#' * `state` = "State or area",
#' * `year` = "Year",
#' * `month` = "Month",
#' * `pop` = "Civilian non-institutional population",
#' * `clf` = "Total numer of people in civilian labor force",
#' * `pc_clf` = "Labor force participation rate (= labor force / population; Age: 16 years and over)",
#' * `emp` = "The number of people employed",
#' * `pc_emp` = "Employment-population ratio (= employment / population; Age: 16 years and over)",
#' * `unem` = "The number of people unemployed",
#' * `unem_rate` = "Unemployment rate (= unemployment / labor force; Age: 16 years and over)"
#'
#' @source [http://www.bls.gov/lau/rdscnp16.htm]()
"state_month_nsa"
