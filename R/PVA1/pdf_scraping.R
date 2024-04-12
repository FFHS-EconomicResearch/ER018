library(tidyverse)
library(pdftools)
library(httr)


# Data Import ----
my_in_file <- "Generative KI im Unternehmen ist der nächste große Schritt_(FAZ_20240325).pdf"

my_text <- pdf_text(xfun::from_root('lit',my_in_file))

## Speichern im rds-Format
my_text_data <- 'GenAi_FAZ_20240325.rds'
my_text %>% write_rds(xfun::from_root('data','raw',my_text_data))

## Text aus .rds laden
my_text <- read_rds(xfun::from_root('data','raw',my_text_data))

# Inspect the document
length(my_text) # 4 Textseiten

text[1] # Text auf Seite 1
text[2] # Text auf Seite 2

text_processed <- str_c(my_text, collapse = "\\n")

# Note that currently this model can only handle 36K Tokens
text_processed %>% str_sub(1, 20000)
