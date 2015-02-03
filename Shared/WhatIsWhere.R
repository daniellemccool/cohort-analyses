install.packages("data.table")
library(data.table)

source("~/R/cohort-analyses/BCACCohort/missingness_table_functions.R")
source("~/R/cohort-analyses/Shared/what_is_where_functions.R")

### Data Frame - What is Where? for which studies have which features

wiw["BCAC", `:=`(Deg1Rel = 1L, Deg2Rel = 1L, BMI = 1l, OralBC = 1L, OralBC_bd = 1L, OralBC_ed = 1L, MenarcheAge = 1L, Parity = 1L, Menopausal = 1L, Status = 1L, Status_ed = 1L, CBC = 1L, Diag_d = 1L, TumorSize = 1L, )]

names <- names(wiw_m["BCAC", wiw_m["BCAC", !is.na(.SD), ], with = FALSE])


wiw["BCAC", names := 1L, with = FALSE]

setkey(wiw_m, Study)
setkey(wiw, Study)


#setwd("~/R/cohort-analyses/Data")
#data2 <- readRDS("data2.RData")
data2 <- data.table(data2)

data2[, (sum(is.na(.SD))/.N), by =  ]
data2[, apply(.EACHI, 2, f <- function(x){is.na(x)/nrow(x)}), ]
t(wiw_m["BCAC"])

write.csv(wiw, "what_is_where.csv")
write.csv(wiw.m, "what_is_where_missing.csv")

wiw <- MakeWiwTable()

f <- function(x, str){x == str}
write.csv(names(wiw)[wiw["BCAC", f(.SD, "Not available"), ]], "not.available.BCAC.csv")
write.csv(names(wiw)[wiw["HEBON", f(.SD, "Not available"), ]], "not.available.HEBON.csv")

?order
