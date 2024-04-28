#https://medium.com/the-whispers-of-a-data-analyst/deciphering-causal-relationships-in-data-a-journey-with-the-pc-algorithm-and-networkx-e45bd32f4f1d

# Download data -----
url = 'https://archive.ics.uci.edu/static/public/109/wine.zip'
wine_data <- download.file(url, xfun::from_root("data","raw","wine.zip"), mode = "wb")

# Import data ------
library(data.table)
tbl_wine <- fread(url, verbose=TRUE)
fread(cmd = paste('unzip -p, xfun::from_root("data","raw","wine.zip"), wine.data'))

library(tidyverse)
tbl_wine <- read_delim(unzip(xfun::from_root("data","raw","wine.zip"), "wine.data"),col_names = FALSE)
