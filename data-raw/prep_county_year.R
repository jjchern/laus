# Labor force data by county, annual averages, 1990-2015

library(tidyverse)

# Download all Excel files ------------------------------------------------

urls = paste0("https://www.bls.gov/lau/laucnty", c(90:99, formatC(0:15, width=2, flag=0)), ".xlsx")
fils = paste0("data-raw/", basename(urls))
map2(urls, fils, download.file)

# Load all Excel files ----------------------------------------------------

readxl::read_excel("data-raw/laucnty90.xlsx", col_names = FALSE, skip = 5)[317,]

tidy <- . %>%
        readxl::read_excel(col_names = FALSE, skip = 5) %>%
        select(-X5) %>%             # Drop An empty column
        filter(X1 != "NA") %>%      # Drop the last four rows
        rename(laus_code = X0,
               state_fips = X1,
               county_fips = X2,
               county = X3,
               year = X4,
               labor_force = X6,
               employed = X7,
               unemployed = X8,
               unemployment_rate = X9) %>%
        separate(county, c("county", "state"), sep = ", ") %>% # Doesn't work for DC
        mutate(state = if_else(county == "District of Columbia", "DC", state)) %>%
        unite(fips, state_fips, county_fips, sep = "", remove = FALSE)

map(fils, tidy) %>% map(head) # Warnings are either about DC or missing values

map_df(fils, tidy) -> county_year
county_year

# Save it! ----------------------------------------------------------------

devtools::use_data(county_year, overwrite = TRUE)
unlink(fils)
