#https://www.paulamoraga.com/book-spatial/r-packages-to-download-open-spatial-data.html

library(rnaturalearth)
library(sf)
library(ggplot2)
library(viridis)
library(patchwork)

map1 <- ne_countries(type = "countries", country = "Germany",
                     scale = "medium", returnclass = "sf")
map2 <- rnaturalearth::ne_states("Germany", returnclass = "sf")
p1 <- ggplot(map1) + geom_sf()
p2 <- ggplot(map2) + geom_sf()
p1 + p2


map1 <- ne_countries(type = "countries", country = "Switzerland",
                     scale = "medium", returnclass = "sf")
map2 <- rnaturalearth::ne_states("Switzerland", returnclass = "sf")
p1 <- ggplot(map1) + geom_sf()
p2 <- ggplot(map2) + geom_sf()
p1 + p2

test <- ne_states("Switzerland", returnclass = "sp")



#https://mhallwor.github.io/_pages/basics_SpatialPolygons
library(raster)
#install.packages('raster')


CH <- raster::getData("GADM", country = "Switzerland", level = 2)
plot(CH)

#install.packages('geos')
library(geos)
CHborder <- geos::geos_boundary(CH)
boundCH<-geos_boundary(map2)
plot(boundCH)

help(geos)

centroid <- plot(geos_centroid(map2))

