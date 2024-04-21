# Import Data ------
#https://insideairbnb.com/get-the-data
library(data.table)
ZH_reviews <- fread('https://data.insideairbnb.com/switzerland/z%C3%BCrich/zurich/2023-12-27/data/reviews.csv.gz')
ZH_listings <- fread('https://data.insideairbnb.com/switzerland/z%C3%BCrich/zurich/2023-12-27/data/listings.csv.gz')


# Cleaning Data -----

## Nutzen von Unicode für Stern: ----
tbl_listings <- ZH_listings %>%
  mutate(rating = str_extract(name, "\u2605\\s*(\\d+\\.\\d+)")) %>%
  mutate(rating = gsub("\u2605", "", rating),
         priceUSD=parse_number(price)) %>%
  mutate(rating = trimws(rating)) %>%
  mutate(rating=as.numeric(rating)) %>%
  rename(listing_id=id) %>%
  select(listing_id,host_id,property_type,room_type,priceUSD,accommodates,rating) %>%
  as_tibble()
head(tbl_listings)

## Nutzen von Stern-Symbol (direkt): ------

tbl_listings <- ZH_listings %>%
                    mutate(rating = str_extract(name, "★\\s*(\\d+\\.\\d+)")) %>%
                    mutate(rating = gsub("★", "", rating),
                           priceUSD=parse_number(price)) %>%
                    mutate(rating = trimws(rating)) %>%
                    mutate(rating=as.numeric(rating)) %>%
                    rename(listing_id=id) %>%
                    select(listing_id,host_id,property_type,room_type,priceUSD,accommodates,rating) %>%
                    as_tibble()
head(tbl_listings)






## more cleaning

#ZH_shiny <- ZH_listings %>%
#   mutate(kreis=factor(neighbourhood_group_cleansed,
#                       levels=c("Kreis 1","Kreis 2","Kreis 3","Kreis 4",
#                                "Kreis 5","Kreis 6","Kreis 7","Kreis 8",
#                                "Kreis 9","Kreis 10","Kreis 11","Kreis 12"
#                       )
#   ),
#   preis=readr::parse_number(price)
#   )
#class(tbl_shiny$preis)
# ZH_shiny %>%
#     select(preis) %>%
#     filter(preis<=2500) %>%
#     unlist() %>%
#     write_rds("ZH_data.rds")



# Combine data -----

tbl_airbnbZH <- ZH_reviews %>%
                    full_join(tbl_listings,by = "listing_id") %>%
                    as_tibble()






# Saving data in .rds-Format -----
my_out_file <- "airbnbZH_20240408.rds"
tbl_airbnbZH %>%
    write_rds(xfun::from_root('data','raw',my_out_file))





