# Employment status of the civilian noninstitutional population, seasonaly adjusted monthly series

library(dplyr, warn.conflicts = FALSE)

# Downloade Statewide Annual Averages -------------------------------------

url = "http://www.bls.gov/lau/ststdsadata.zip"
fil = "data-raw/ststdsadata.zip"
if (!file.exists(fil)) downloader::download(url, fil)
unzip(fil, exdir = "data-raw")
list.files("data-raw")

# Load the data, add variable name, and variable labels -------------------

readxl::read_excel(path = "data-raw/ststdsadata.xlsx",
                   col_name = c("fips", "state", "year", "month", "pop", "clf", "pc_clf", "emp", "pc_emp", "unem", "unem_rate"),
                   skip = 8) -> state_month_sa

labelled::var_label(state_month_sa) = list(
        fips = "FIPS code",
        state = "State or area",
        year = "Year",
        month = "Month",
        pop = "Civilian non-institutional population",
        clf = "Total numer of people in civilian labor force",
        pc_clf = "Labor force participation rate (= labor force / population; Age: 16 years and over)",
        emp = "The number of people employed",
        pc_emp = "Employment-population ratio (= employment / population; Age: 16 years and over)",
        unem = "The number of people unemployed",
        unem_rate = "Unemployment rate (= unemployment / labor force; Age: 16 years and over)"
)

# Save it! ----------------------------------------------------------------

devtools::use_data(state_month_sa, overwrite = TRUE)
unlink(fil)
