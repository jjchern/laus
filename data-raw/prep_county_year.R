# Labor force data by county, annual averages, 1990-2016

library(tidyverse)

# Download all Excel files ------------------------------------------------

urls = paste0("https://www.bls.gov/lau/laucnty", c(90:99, formatC(0:16, width=2, flag=0)), ".xlsx")
fils = paste0("data-raw/county_year/", basename(urls))
map2(urls, fils, download.file)

# Check out a few files ---------------------------------------------------

fils[1] %>%
    readxl::read_excel(col_names = FALSE, skip = 5) %>%
    select(-X__6) %>%         # Drop An empty column
    filter(X__2 != "NA") %>%  # Drop the last few rows
    rename(laus_code = X__1,
           state_fips = X__2,
           county_fips = X__3,
           county = X__4,
           year = X__5,
           labor_force = X__7,
           employed = X__8,
           unemployed = X__9,
           unemployment_rate = X__10) %>%
    separate(county, c("county", "state"), sep = ", ") %>% # Doesn't work for DC
    unite(fips, state_fips, county_fips, sep = "", remove = FALSE)

# Error message in row 317
readxl::read_excel("data-raw/county_year/laucnty90.xlsx", col_names = FALSE, skip = 5)[317,]

# Load all Excel files ----------------------------------------------------

tidy <- . %>%
    readxl::read_excel(col_names = FALSE, skip = 5) %>%
    select(-X__6) %>%         # Drop An empty column
    filter(X__2 != "NA") %>%  # Drop the last few rows
    rename(laus_code = X__1,
           state_fips = X__2,
           county_fips = X__3,
           county = X__4,
           year = X__5,
           labor_force = X__7,
           employed = X__8,
           unemployed = X__9,
           unemployment_rate = X__10) %>%
    separate(county, c("county", "state"), sep = ", ") %>% # Doesn't work for DC
    unite(fips, state_fips, county_fips, sep = "", remove = FALSE)

map(fils, tidy) %>% map(head) # Warnings are either about DC or missing values

map_df(fils, tidy) -> county_year
county_year

# Save it! ----------------------------------------------------------------

devtools::use_data(county_year, overwrite = TRUE)
