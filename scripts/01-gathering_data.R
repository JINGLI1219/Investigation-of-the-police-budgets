#### Preamble ####
# Purpose: Clean the data downloaded from "Open Data Toronto portal"
# Author: Jing Li
# Data: 27 April 2022
# Contact: jingle.li@mail.utoronto.ca
# License: MIT




#### Workspace setup ####

# Load packages
library(tidyverse)
library(opendatatoronto)
library(dplyr)
library(modelsummary)
ppackage <- show_package("668434ee-9541-40a8-adb6-0ad805fcc9b6")
package
resources <- list_package_resources("668434ee-9541-40a8-adb6-0ad805fcc9b6")
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))
data_open <- filter(datastore_resources, row_number()==1) %>% get_resource()
data_open



data_command <-
  data_open %>% 
  mutate(is_command = if_else(Pillar_Name == "East Field Command" | 
                                Pillar_Name == "Human Resources Command" |
                                Pillar_Name == "Communities & Neighbourhoods Command" |
                                Pillar_Name == "Corporate Support Command" |
                                Pillar_Name == "Information Technology Command" |
                                Pillar_Name == "Priority Response Command" |
                                Pillar_Name == "Specialized Operations Command" |
                                Pillar_Name == "West Field Command", 1 , 0))

data_org <-
  data_command %>% 
  mutate(organization_num = case_when(Organization_Entity <= "1 - Toronto Police Service" ~ 1, 
                                      Organization_Entity == "2 - TPS Board" ~ 2,
                                      Organization_Entity == "3 - Parking Enforcement Unit" ~ 3))

data_mod <-
  data_org %>% 
  mutate(rev_or_sal = if_else(grepl("Salaries", Cost_Element_Long_Name,
                                    ignore.case = TRUE), 1, 0))
data_fin <- na.omit(data_mod)

