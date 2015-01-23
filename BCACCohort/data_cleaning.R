# SetNAs <- function(data, missing){
#   for(i in missing){
#     data[data == i] <- NA
#   }
# }

SetToNA = function(data){
  for (i in names(data)){
    data[get(i) == "8000-08-08", i:=NA, with = FALSE]
    data[get(i) == 888, i:=NA, with = FALSE]
  }
  data
}


# This is how the col names for factors and ordered variables were originally
# generated, however in order to preserve the integrity of the data for the
# future, they are now loaded from RData files generated as shown.

# factor_cols <- quote(c(2:20, 21:23, 33:37, 41:49, 52:57, 60, 61:65, 67:72,
# 76:80, 81, 85:88, 91, 93:99, 101:104, 106, 108, 110, 112, 114, 116:120,
# 121:124, 127, 129:135, 137, 141, 147, 153, 155, 157, 159, 161, 164:167,
# 169:170, 172, 175:176))

#ordered_cols <- quote(c(27:32, 66, 73, 74, 82:83, 136, 139:140, 143:146))

#f_colnames <- colnames(data_test[, eval(factor_cols), with = FALSE])
#saveRDS(f_colnames, "f_colnames.RData")

# o_colnames <- colnames(data_test[, eval(factor_cols), with = FALSE])
# saveRDS(o_colnames, "o_colnames.RData")

SetClassData <- function(data){
  setwd("~/RScripts") # To set it to where the names are stored
  f_colnames <- quote(readRDS("f_colnames.RData"))
  o_colnames <- quote(readRDS("o_colnames.RData"))
  
  data[, eval(f_colnames) := lapply(.SD, as.factor), .SDcols = eval(f_colnames)]
  data[, eval(o_colnames) := lapply(.SD, as.ordered), .SDcols = eval(o_colnames)]
  
  data
  
}
data[, 1:176 := lapply(.SD, as.numeric), .SDcols = 1:176]
data <- SetClassData(data)
library(foreign)
cb_p2 <- read.csv("BCAC_Extended_Data_Dictionary.csv", header = TRUE, sep = ";", stringsAsFactors = FALSE)
?read.csv
desc <- cb_p2$Label
desc <- c("BCAC unique person identifier", "BCAC acronym for study", desc)
desc <- append(desc[-(30:38)], desc[30:38], after = 23)
desc <- append(desc, c("Description of TNM code of first tumor", "Description of TNM code of second tumor"), after = 32 )
desc <- append(desc[-(41:43)], desc[41:43], after = 34)
desc <- append(desc[-(41:43)], desc[41:43], after = 37)
desc <- append(desc, c("Ariol Measurement of ER intensity", "Ariol Measurement of ER Percentage"), after = 49)
desc <- append(desc, c("Ariol Measurement of PR intensity", "Ariol Measurement of PR Percentage"), after = 57)
desc <- append(desc, "Ariol HER2 Score", after = 65)
desc <- append(desc, c("EGFR Intensity Derived", "EGFR Proportion Derived", "EGFR Percentage"), after = 72)
desc <- c(desc, c("CK5/6 Intensity Derived", "CK5/6 Proportion Derived", "CK5/6 Percentage"))

x <- readClipboard()
desc <- c(desc, x)
length(desc)

as.data.frame(desc)
as.data.frame(names(data))

#saveRDS(desc, "VariableDescriptionsforCodebook.RData")
description(data) <- desc
?ifelse
summary(data)
data_ds <- data.set(data)

for(i in ncol(data_ds)){
  description(data_ds[, i]) <- desc[i]
}
description(data_ds[, 1]) <- desc[1]
test <- data_ds[, 147]
labels(test) <- c("No Bilaterality" = 0,
                 "Contralateral" = 1,
                 "Ipsilateral" = 2)

description(test) <- desc[147]
test

test2 <- data_ds[, 148]
description(test2) <- desc[148]
length(data_ds)
length(desc)
class(data_ds)
class(data)
