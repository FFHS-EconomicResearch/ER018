library(tidyverse)
library(babynames) #US Babys



# Extracting vectors for boys' and girls' names
babynames_2014 <- filter(babynames, year == 2014)
boy_names <- filter(babynames_2014, sex == "M")$name
girl_names <- filter(babynames_2014, sex == "F")$name

# Take a look at a few boy_names
head(boy_names)

# Find the length of all boy_names
boy_length <- str_length(boy_names)

# Take a look at a few lengths
head(boy_length)

# Find the length of all girl_names
girl_length <- str_length(girl_names)
girl_length
# Find the difference in mean length
mean(girl_length)-mean(boy_length)

# Confirm str_length() works with factors
head(str_length(boy_names))
head(str_length(factor(boy_names)))


# str_sub -----

# Extract first letter from boy_names
boy_first_letter <- str_sub(boy_names,1,1)

# Tabulate occurrences of boy_first_letter
table(boy_first_letter)

# Extract the last letter in boy_names, then tabulate
boy_last_letter <- str_sub(boy_names,-1,-1)
table(boy_last_letter)

# Extract the first letter in girl_names, then tabulate
girl_first_letter <- str_sub(girl_names,1,1)
table(girl_first_letter)

# Extract the last letter in girl_names, then tabulate
girl_last_letter <- str_sub(girl_names,-1,-1)
table(girl_last_letter)

# Detecting matching patterns ----

## str_detect() ----
# Look for pattern "zz" in boy_names
contains_zz <- str_detect(boy_names,pattern=fixed("zz"))

# Examine str() of contains_zz
str(contains_zz)

# How many names contain "zz"
sum(contains_zz==TRUE)

# Which names contain "zz"?
boy_names[contains_zz==TRUE]


# Which rows in boy_df have names that contain "zz"?
boy_df[contains_zz, ]
boy_df %>% filter(name%in%boy_names[contains_zz==TRUE])

## str_subset()----
# Find boy_names that contain "zz"
str_subset(boy_names,pattern=fixed("zz"))

# Find girl_names that contain "zz"
str_subset(girl_names,pattern=fixed("zz"))

# Find girl_names that contain "U"
starts_U <- str_subset(girl_names,pattern=fixed("U"))
starts_U

# Find girl_names that contain "U" and "z"
str_subset(starts_U,pattern=fixed("z"))


## Häufigkeiten matching patterns ----

# Count occurrences of "a" in girl_names
number_as <-str_count(girl_names,pattern=fixed("a"))

# Count occurrences of "A" in girl_names
number_As <- str_count(girl_names,pattern=fixed("A"))

# Histograms of number_as and number_As
hist(number_as)
hist(number_As)

# Find total "a" + "A"
total_as <- number_As+number_as

# girl_names with more than 4 a's
girl_names[total_as>4]

## str_split() -----

# Some date data
date_ranges <- c("23.01.2017 - 29.01.2017", "30.01.2017 - 06.02.2017")

# Split dates using " - "
split_dates <- str_split(date_ranges,pattern=" - ",simplify=FALSE)
split_dates

# Split dates with n and simplify specified
split_dates_n <- str_split(date_ranges,pattern=fixed(" - "), n = 2,simplify=TRUE)
split_dates_n

# Subset split_dates_n into start_dates and end_dates
start_dates <- split_dates_n[,1]
start_dates
# Split start_dates into day, month and year pieces
str_split(start_dates,pattern=fixed("."),simplify=TRUE)

both_names <- c("Box, George", "Cox, David")

# Split both_names into first_names and last_names
both_names_split <- str_split(both_names,pattern=fixed(", "),simplify=TRUE)

# Get first names
first_names <- both_names_split[,2]

# Get last names
last_names <- both_names_split[,1]
last_names



# Split lines into words ----

## Creating Object -----
# Define line1
line1 <- "The table was a large one, but the three were all crowded together at one corner of it:"
# Define line2
line2 <- '"No room! No room!" they cried out when they saw Alice coming.'
# Define line3
line3 <- "\"There's plenty of room!\" said Alice indignantly, and she sat down in a large arm-chair at one end of the table."
# Putting lines in a vector
lines <- c(line1, line2, line3)
# Print lines
lines
# Use writeLines() on lines
writeLines(lines)
# Write lines with a space separator
writeLines(lines,sep=" ")
# Use writeLines() on the string "hello\n\U1F30D"
writeLines("hello\n\U1F30D")

## splitting lines object -----
words <- str_split(lines,pattern=fixed(" "))

# Number of words per line
lapply(words,length)

# Number of characters in each word
word_lengths <- lapply(words,str_length)
word_lengths
# Average word length per line
lapply(word_lengths,mean)

# Replacing with str_replace() ----

# Some (fake) phone numbers
phone_numbers <- c("510-555-0123", "541-555-0167")

# Use str_replace() to replace "-" with " "
str_replace(phone_numbers,"-"," ")

# Use str_replace_all() to replace "-" with " "
str_replace_all(phone_numbers,"-"," ")

# Turn phone numbers into the format xxx.xxx.xxxx
str_replace_all(phone_numbers,"-",".")


# Define some full names
names <- c("Diana Prince", "Clark Kent")

# Split into first and last names
names_split <- str_split(names," ",simplify=TRUE)
names_split
# Extract the first letter in the first name
abb_first <- str_sub(names_split[,1],start=1,end=1)
abb_first
# Combine the first letter ". " and last name
str_c(abb_first,". ",names_split[,2])


# Combing stringr-functions -----

# Use all names in babynames_2014
all_names <- babynames_2014$name

# Get the last two letters of all_names
last_two_letters <- str_sub(all_names,-2,-1)
last_two_letters
# Does the name end in "ee"?
ends_in_ee <- str_detect(last_two_letters,pattern=fixed("ee"))
ends_in_ee
# Extract rows and "sex" column
sex <- babynames_2014$sex[ends_in_ee==TRUE]
sex
# Display result as a table
table(sex)


# Regular Expressions -----

## regexp with rebus ----
install.packages("rebus")
library(rebus)
# Some srebus# Some strings to practice with
x <- c("cat", "coat", "scotland", "tic toc")

# Print END
END

# Run me
str_view(x, pattern = START %R% "t")

# Match the strings that end with "at"
str_view(x, pattern="at" %R% END)

# Match the string that is exactly "cat"
str_view(x, pattern = START %R% "cat" %R% END)

#Match string with patterns "c_t"
str_view(x, pattern = "c" %R% ANY_CHAR %R% "t")

# Match a "t" followed by any character
str_view(x, pattern = "t" %R% ANY_CHAR)

# Match a string with exactly three characters
str_view(x, pattern = START %R% ANY_CHAR %R% ANY_CHAR %R% ANY_CHAR %R% END)

## Combining regexp with stringr-functions ----
x <- c("cat", "coat", "scotland", "tic toc")
pattern <- "c" %R% ANY_CHAR %R% "t"
str_detect(x, pattern)
str_subset(x, pattern)
str_count(x, pattern)

# Find part of name that matches pattern
part_with_q <- str_extract(boy_names,pattern= "q" %R% ANY_CHAR)
# Get a table of counts
table(part_with_q)


# Did any names have the pattern more than once?
count_of_q <- str_count(boy_names,pattern="q" %R% ANY_CHAR)

# Get a table of counts
table(count_of_q)

# Which babies got these names?
with_q <- str_detect(boy_names,pattern="q" %R% ANY_CHAR)

# What fraction of babies got these names?
mean(with_q)



## char_class() -----

x <- c("grey sky", "gray elephant")

# Create character class containing vowels
vowels <- char_class("Aa","Ee","Ii","Oo","Uu")

# Print vowels
vowels

# See vowels in x with str_view()
str_view(x,pattern=vowels,match=TRUE)

# Calc mean number of vowels
mean(str_count(boy_names,pattern=vowels))

# Calc mean fraction of vowels per name
mean( str_count(boy_names,pattern=vowels)/str_count(boy_names))





# Schweiz --------

## Datenimport -----
#Bundesamt für Statistik
library(readxl)

my_in_file <- 'su-d-01.04.00.03_(BFS_20240406).xlsx'
babynamesCH_raw <- read_excel(xfun::from_root('data','raw',my_in_file),sheet='Schweiz',skip = 2)

## Data-Wrangling ----

### separating sheet into boys/girls ----
boys_raw <- babynamesCH_raw %>%
                select(1:13) %>%
                mutate(gender='boys') %>%
                relocate(gender, .after = Knaben) %>%
                rename(Vorname=Knaben)

girls_raw <- babynamesCH_raw %>%
                  select(14:26) %>%
                  mutate(gender='girls') %>%
                  relocate(gender, .after = Mädchen) %>%
                  rename(Vorname=Mädchen)

### prototyping tidying -----
tmp <- boys_raw %>%
  select(1:4) %>%
  {
    year <- colnames(.) %>% last() %>% str_sub(1, 4)  # Extract the desired name for the new column
    tmp <- unite(., col = tmp_name, sep = '/', 3:4) %>% # Unite columns 2 and 3 with the new column name
    rename_with(~year, starts_with("tmp_name"))
  } %>%
  pivot_longer(-c(Vorname,gender),names_to ="year",
               values_to = "cases") %>%
  filter(Vorname!="Vornamen") %>%
  separate(cases, sep = "/",
                       into = c("rank", "count")) %>%
  mutate(rank=as.numeric(rank),count=as.numeric(count)) %>%
  filter(!is.na(rank))


### using prototype to tidy data with purrr -----
library(dplyr)
library(stringr)
library(purrr)

# Define a function to perform the desired operations on pairs of columns
process_columns <- function(data, start_col, end_col) {
  print(paste("start_col:", start_col, ", end_col:", end_col))  # Print start_col and end_col
  data %>%
    select(c(1:2), start_col:end_col) %>%
    {
      year <- colnames(.) %>% last() %>% str_sub(1, 4)  # Extract the desired name for the new column
      tmp <- unite(., col = "tmp_name", sep = '/', 3:4) %>% # Unite the selected columns with the new column name
      rename_with(~year, starts_with("tmp_name"))  # Rename the united column with the content stored in 'year'
    } %>%
    pivot_longer(-c(Vorname, gender), names_to = "year", values_to = "cases") %>%
    filter(Vorname != "Vornamen") %>%
    separate(cases, sep = "/", into = c("rank", "count")) %>%
    mutate(rank = as.numeric(rank), count = as.numeric(count)) %>%
    filter(!is.na(rank))
}


# Determine the range of columns to process (e.g., 4th and 5th, 6th and 7th, etc.)
column_ranges <- seq(3, ncol(boys_raw)-1, by = 2)
column_ranges
# Apply the function to each pair of columns and combine the results
boys_tidy <- map_dfr(column_ranges, ~ process_columns(boys_raw, .x, .x + 1))
girls_tidy <- map_dfr(column_ranges, ~ process_columns(girls_raw, .x, .x + 1))

tbl_babynamesCH <- rbind(girls_tidy,boys_tidy)

### save tidy tibble -----
my_out_file <- 'BabynamesCH_(BFS_2024).rds'
tbl_babynamesCH %>%
  write_rds(xfun::from_root('data','tidy',my_out_file))



# Exploring CH-Babynames -----
my_in_file <- 'BabynamesCH_(BFS_2024).rds'
tbl_babynamesCH <- read_rds(xfun::from_root('data','tidy',my_in_file))


## Namen mit bestimmten Anfangsbuchstaben in bestimmten Jahren ----
### Knaben mit C im Jahr 2019 ----
tbl_babynamesCH %>%
   filter(year==2019,gender=='boys',str_starts(Vorname, "C"))
### Mädchen mit F im Jahr 2021 ----
tbl_babynamesCH %>%
   filter(year==2021,gender=='girls',str_starts(Vorname, "F"))

## Länge der Namen  ------

länge <- tbl_babynamesCH %>%
               mutate(name_length = str_length(Vorname)) %>%
               group_by(year, gender) %>%
               summarise(mean_name_length = mean(name_length),
                         median_name_length = median(name_length),
                         max_name_length = max(name_length))
länge
## Häufigkeit Anfangsbuchstaben ----
anfangsbuchstabe <- tbl_babynamesCH %>%
                        mutate(first_letter = substr(Vorname, 1, 1)) %>%
                        group_by(year,gender, first_letter) %>%
                        count()

p <- anfangsbuchstabe %>%
        mutate(gender = factor(gender, levels = c("boys", "girls"))) %>%
        group_by(gender,year) %>%
        arrange(desc(n)) %>%
        slice_max(n=10,order_by = n) %>%
        ggplot(aes(x=first_letter,y=n,fill=fct_reorder(gender,n))) +
          geom_col(position = 'dodge') +
          facet_wrap(~fct_rev(year),scales = "free_x") +
          scale_fill_discrete(labels = c("girls" = "Mädchen", "boys" = "Knaben")) +
          labs(x='Anfangsbuchstabe',y='absolute Häufigkeit')+
          theme(legend.position = "bottom", legend.title = element_blank())

p

library(cowplot)
p1 <- add_sub(p, "Nur die ersten 200 Vornamen mit mind. zwei Beobachtungen in 2022.",
              hjust = 1.4,
              fontface = "plain",
              size= 9)
ggdraw(p1)

tbl_babynamesCH %>%
  group_by(gender) %>%
  arrange(desc(count)) %>%
  print()


tbl_babynamesCH %>%
  group_by(gender,count) %>%
  filter(year==2022,str_starts(Vorname, "Sa"))

tbl_babynamesCH$Vorname %>%
  str_view(pattern=or("Phi","Fi"),match=TRUE) %>%
  janitor::tabyl()
