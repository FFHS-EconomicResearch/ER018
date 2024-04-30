#https://bookdown.org/markhoff/social_network_analysis/ego-networks.html
library(tidyverse)
tbl_gss <- read_csv("https://raw.githubusercontent.com/mahoffman/stanford_networks/main/data/gss_local_nets.csv")

ties <- tbl_gss %>%
              select(starts_with("close"))
