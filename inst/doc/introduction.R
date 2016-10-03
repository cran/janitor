## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
library(janitor)

## ---- message = FALSE, warning = FALSE-----------------------------------
# Load dplyr for the %>% pipe
library(dplyr)
# Create a data.frame with dirty names
test_df <- as.data.frame(matrix(ncol = 6))
names(test_df) <- c("hIgHlo", "REPEAT VALUE", "REPEAT VALUE",
                    "% successful (2009)",  "abc@!*", "")

## ------------------------------------------------------------------------
test_df %>%
  clean_names()

## ------------------------------------------------------------------------
make.names(names(test_df))

## ------------------------------------------------------------------------
x <- c("a", "b", "c", "c", NA)
tabyl(x, sort = TRUE)

## ------------------------------------------------------------------------
table(x)

## ------------------------------------------------------------------------
mtcars %>%
  filter(gear > 3) %>%
  tabyl(cyl)

## ------------------------------------------------------------------------
y <- c(1, 1, 2, 1, 2)
x <- c("a", "a", "b", "b", NA)

crosstab(x, y)
crosstab(x, y, percent = "row")

## ------------------------------------------------------------------------
dat <- data.frame(x, y)
dat %>%
  crosstab(x, y, percent = "row")

## ---- message=FALSE, results = "hide"------------------------------------
library(dplyr) ; library(tidyr)
dat %>%
  group_by(x, y) %>%
  tally() %>%
  mutate(percent = n / sum(n, na.rm = TRUE)) %>%
  select(-n) %>%
  spread(y, percent, fill = 0) %>%
  ungroup()

## ------------------------------------------------------------------------
mtcars %>%
  crosstab(cyl, gear) %>%
  adorn_crosstab()

## ------------------------------------------------------------------------
get_dupes(mtcars, wt, cyl) # or mtcars %>% get_dupes(wt, cyl) if you prefer to pipe

## ---- eval = FALSE-------------------------------------------------------
#  ifelse(!is.na(sensorA), sensorA,
#         ifelse(!is.na(sensorB), sensorB,
#                sensorC))

## ---- eval = FALSE-------------------------------------------------------
#  use_first_valid_of(sensorA, sensorB, sensorC)

## ------------------------------------------------------------------------
excel_numeric_to_date(41103)
excel_numeric_to_date(41103, date_system = "mac pre-2011")

## ------------------------------------------------------------------------
convert_to_NA(letters[1:5], c("b", "d"))

## ------------------------------------------------------------------------
q <- data.frame(v1 = c(1, NA, 3),
                v2 = c(NA, NA, NA),
                v3 = c("a", NA, "b"))
q %>%
  remove_empty_cols() %>%
  remove_empty_rows()

## ------------------------------------------------------------------------
mtcars %>%
  crosstab(am, cyl) %>%
  add_totals_row %>%
  add_totals_col

## ------------------------------------------------------------------------
mtcars %>%
  crosstab(cyl, am) %>%
  ns_to_percents("col")

## ------------------------------------------------------------------------
f <- factor(c("strongly agree", "agree", "neutral", "neutral", "disagree", "strongly agree"),
            levels = c("strongly agree", "agree", "neutral", "disagree", "strongly disagree"))
top_levels(f)
top_levels(f, n = 1, sort = TRUE)

