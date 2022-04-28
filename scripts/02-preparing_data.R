#### Preamble ####
# Purpose: prepare the data downloaded from "Open Data Toronto portal"
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



data_open %>% 
  ggplot(aes(x = Amount)) + facet_wrap(~Feature_Category) +
  geom_histogram()

data_open %>% 
  ggplot(aes(x = Amount, y = Organization_Entity)) +
  geom_point()

regress <- 
  lm(Amount ~ is_command + organization_num + rev_or_sal + Feature_Category, 
     data = data_fin)
summary(regress)

modelsummary(regress,
             title = "Coefficients of Regression")