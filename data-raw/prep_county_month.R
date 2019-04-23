
# Labor force data by county, annual averages, 1990-01 - 2019-02

library(tidyverse)

# Meta --------------------------------------------------------------------

urls = c("https://download.bls.gov/pub/time.series/la/la.period",
    "https://download.bls.gov/pub/time.series/la/la.state_region_division",
    "https://download.bls.gov/pub/time.series/la/la.measure",
    "https://download.bls.gov/pub/time.series/la/la.footnote",
    "https://download.bls.gov/pub/time.series/la/la.area_type",
    "https://download.bls.gov/pub/time.series/la/la.area")

map(urls, ~ read_tsv(.x) %>% assign(basename(.x), ., envir = .GlobalEnv))

# County monthly laus -----------------------------------------------------

read_tsv("https://download.bls.gov/pub/time.series/la/la.data.64.County") %>%
    print() -> raw

# Breakdown series id -----------------------------------------------------
# See https://download.bls.gov/pub/time.series/la/la.txt

raw %>%
    mutate(area_code = substr(series_id, 4, 18)) %>%
    mutate(seasonal = substr(series_id, 3, 3)) %>%
    mutate(fips = substr(series_id, 6, 10)) %>%
    mutate(state_fips = substr(series_id, 6, 7)) %>%
    mutate(county_fips = substr(series_id, 8, 10)) %>%
    mutate(measure_code = substr(series_id, nchar(series_id) - 1, nchar(series_id))) %>%
    print(n = 20) -> raw2

# Add area_text -----------------------------------------------------------

la.area %>%
    select(area_code, area_text) %>%
    right_join(raw2) %>%
    mutate(area_text = if_else(area_text == "District of Columbia",
        paste0(area_text, ", DC"), area_text)) %>%
    separate(area_text, c("county", "state"), sep = ", ") %>%
    select(-series_id, -area_code) %>%
    select(fips, state_fips, county_fips, county, state, year, everything()) %>%
    print(n = 20) -> raw3

# Spread by measures ------------------------------------------------------

raw3 %>%
    left_join(la.measure) %>%
    select(-measure_code) %>%
    spread(measure_text, value) %>%
    print(n = 20) -> raw4

# Add period and footnote codes -------------------------------------------

raw4 %>%
    left_join(la.period) %>%
    mutate(month = substr(period, 2, 3)) %>%
    mutate(month = if_else(month == 13, NA_character_, month)) %>%
    print(n = 20) %>%
    left_join(la.footnote, by = c("footnote_codes" = "footnote_code")) %>%
    select(-footnote_codes) %>%
    select(fips, state_fips, county_fips,
           county, state, year, month,
           employment, `labor force`, unemployment, `unemployment rate`,
           seasonal, everything()) %>%
    print(n = 20) -> raw5

# Don’t include annual average --------------------------------------------
# And don't include 2019-03
raw5 %>% filter(!is.na(month)) -> county_month_nsa

county_month_nsa %>% count(year, month) %>% print(n = 351)
county_month_nsa %>% filter(!(year == 2019 & month == "03")) -> county_month_nsa

usethis::use_data(county_month_nsa, overwrite = TRUE)
