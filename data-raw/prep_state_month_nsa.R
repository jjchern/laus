# Employment status of the civilian noninstitutional population, not seasonaly adjusted monthly series
# 1976.1 - 2017.11
# For more information, see https://www.bls.gov/web/laus.supp.toc.htm

library(tidyverse)

# Downloade Statewide Annual Averages -------------------------------------

url = "https://www.bls.gov/web/laus/ststdnsadata.zip"
fil = "data-raw/state_month/ststdnsadata.zip"
if (!file.exists(fil)) downloader::download(url, fil)
unzip(fil, exdir = "data-raw/state_month")
list.files("data-raw/state_month")

# Load the data, add variable name, and variable labels -------------------

readxl::read_excel(path = "data-raw/state_month/ststdnsadata.xlsx",
                   col_name = c("fips", "state", "year", "month", "pop", "clf", "pc_clf", "emp", "pc_emp", "unem", "unem_rate"),
                   skip = 8) %>%
    print() -> state_month_nsa

labelled::var_label(state_month_nsa) = list(
        fips = "FIPS code",
        state = "State or area",
        year = "Year",
        month = "Month",
        pop = "Civilian non-institutional population",
        clf = "Total number of people in civilian labor force",
        pc_clf = "Labor force participation rate (= labor force / population; Age: 16 years and over)",
        emp = "Total number of people employed",
        pc_emp = "Employment-population ratio (= employment / population; Age: 16 years and over)",
        unem = "Total number of people unemployed",
        unem_rate = "Unemployment rate (= unemployment / labor force; Age: 16 years and over)"
)

# Drop LA and NYC ---------------------------------------------------------

state_month_nsa %>%
    anti_join(fips::state)

state_month_nsa %>%
    filter(fips != "037" & fips != "51000") %>%
    print() -> state_month_nsa

# Save it! ----------------------------------------------------------------

devtools::use_data(state_month_nsa, overwrite = TRUE)
