# install.packages("ecocomDP")

library(ecocomDP)
library(tidyverse)

# how to find the mammal data in ecocomDP
data_list <- ecocomDP::search_data("mammal")
View(data_list)

# the id for the neon small mammal data mapped to ecocomDP
my_id <- "neon.ecocomdp.10072.001.001"

# read neon data -- 
#   for the two sites specified below, download size is ~52 MB. 
#   for all NEON sites, download size is ~ 595 MB
my_ecocomDP_data <- ecocomDP::read_data(
  id = my_id,
  site = c("CPER","OSBS"), #comment out this line to download all sites
  token = Sys.getenv("NEON_TOKEN"),
  check.size = FALSE)

# save data initial download locally (RDS file is only 39.7KB)
saveRDS(my_ecocomDP_data, "data/my_ecocomDP_data.RDS")

# read in data from local file
my_ecocomDP_data <- readRDS("data/my_ecocomDP_data.RDS")


# flatten data
data_flat <- my_ecocomDP_data[[1]]$tables %>%
  ecocomDP::flatten_data() %>%
  mutate(
    season = case_when(
      month %in% c(1:3) ~ "winter",
      month %in% c(4:6) ~ "spring",
      month %in% c(7:9) ~ "summer",
      month %in% c(10:12) ~ "fall",
      TRUE ~ NA_character_)) %>%
  dplyr::select(
    observation_id, event_id,
    year, season,
    siteID, domainID, nlcdClass,
    taxon_rank,
    taxon_id, 
    variable_name, value, unit) %>%
  dplyr::filter(value > 0)

# average counts for each taxon_id within a season
data_by_site_year_season_taxon <- data_flat %>%
  group_by(siteID, year, season, taxon_id) %>%
  summarize(
    count_per_100_trapnight = mean(value)) %>%
  ungroup()
  
# sum average counts for each taxon in each season to 
# get estimate of total small mammal count per trapping effort
data_by_site_year_season <- data_by_site_year_season_taxon %>%
  dplyr::filter(count_per_100_trapnight > 0) %>%
  group_by(siteID, year, season) %>%
  summarize(
    total_count_per_100_trapnight = sum(count_per_100_trapnight),
    richness = length(unique(taxon_id)))

# get site info data
site_info <- read_csv(file = "https://www.neonscience.org/sites/default/files/NEON_Field_Site_Metadata_20210226_0.csv") %>%
  dplyr::select(
    domain_id, site_id, site_name,
    site_type, 
    latitude, longitude,
    mean_elevation_m, minimum_elevation_m, maximum_elevation_m, 
    mean_annual_temperature_C, mean_annual_precipitation_mm, 
    dominant_wind_direction, 
    mean_canopy_height_m, dominant_nlcd_classes, domint_plant_species,
    usgs_geology_unit, megapit_soil_family, soil_subgroup,
    avg_number_of_green_days, avg_green_max_doy)
  

# rename columns
names(site_info) <- names(site_info) %>% gsub("field_","",.)

# combine site info data with small mammal data
data_merged <- data_by_site_year_season %>% 
  left_join(
    site_info,by = c("siteID" = "site_id"))

# write to the data subdir
write_csv(data_merged, "data/data.csv")

