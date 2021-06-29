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

data_flat <- my_ecocomDP_data[[1]]$tables %>%
  ecocomDP::flatten_data() %>%
  mutate(
    season = case_when(
      month %in% c(12:2)
    )
  )

