library(spData)
library(sf)
library(mapview)
map <- st_read(system.file("shapes/boston_tracts.shp",
                           package = "spData"), quiet = TRUE)
map$vble <- map$MEDV
mapview(map, zcol = "vble")
