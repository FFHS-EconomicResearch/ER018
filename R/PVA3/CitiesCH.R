library(readxl)
#install.packages("BFS") #ggf Paket installieren
library(BFS)

# Use BFS API to get City data CH -----
## Browse Catalog ----
bfs_get_catalog_data(language = "de", title = "Demografische")

## get Order No ----
asset_no <- "26645070"
asset_meta <- bfs_get_asset_metadata(number_asset=asset_no)
bfs_no <- asset_meta$shop$orderNr

## get data ----
bfs_get_data(number_bfs = bfs_no, language = "de")





my_in_file <- "CitiesCH_(bfs)_su-b-ssv-01.02.01.01-2024.xlsx"
tbl_citiesCH <- read_excel(xfun::from_root("data","raw","PVA3",my_in_file),skip = 3)
