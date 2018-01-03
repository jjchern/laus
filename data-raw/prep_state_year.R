# Employment status of the civilian noninstitutional population, annual averages series

library(tidyverse)

# Downloade Statewide Annual Averages -------------------------------------

url = "http://www.bls.gov/lau/staadata.zip"
fil = "data-raw/state_year/staadata.zip"
if (!file.exists(fil)) downloader::download(url, fil)
unzip(fil, exdir = "data-raw/state_year")
list.files("data-raw/state_year")

# Load the data, add variable name, and variable labels -------------------

readxl::read_excel(path = "data-raw/state_year/staadata.xlsx",
                   col_name = c("fips", "state", "year", "pop", "clf", "pc_clf", "emp", "pc_emp", "unem", "unem_rate"),
                   skip = 8) %>%
    print() -> state_year

labelled::var_label(state_year) = list(
        fips = "FIPS code",
        state = "State or area",
        year = "Year",
        pop = "Civilian non-institutional population",
        clf = "Total number of people in civilian labor force",
        pc_clf = "Labor force participation rate (= labor force / population; Age: 16 years and over)",
        emp = "Total number of people employed",
        pc_emp = "Employment-population ratio (= employment / population; Age: 16 years and over)",
        unem = "Total number of people unemployed",
        unem_rate = "Unemployment rate (= unemployment / labor force; Age: 16 years and over)"
)

# Drop LA and NYC ---------------------------------------------------------

state_year %>%
    anti_join(fips::state)

state_year %>%
    filter(fips != "037" & fips != "51000") %>%
    print() -> state_year

# Save it! ----------------------------------------------------------------

devtools::use_data(state_year, overwrite = TRUE)
