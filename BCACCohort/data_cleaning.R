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

# factor_cols <- c(2:20, 21:23, 33:37, 41:49, 52:57, 60, 61:65, 67:72,
# 76:80, 81, 85:88, 91, 93:99, 101:104, 106, 108, 110, 112, 114, 116:120,
# 121:124, 127, 129:135, 137, 141, 147, 153, 155, 157, 159, 161, 164:167,
# 169:170, 172, 175:176)

#ordered_cols <- c(27:32, 66, 73, 74, 82:83, 136, 139:140, 143:146)
#date_cols <- which(data[, lapply(.SD, class), ] == "POSIXt", arr.ind = TRUE)[, 2]


sum(is.na(wiw))
#f_colnames <- colnames(data[, eval(factor_cols), with = FALSE])
#saveRDS(f_colnames, "f_colnames.RData")

# o_colnames <- colnames(data[, eval(ordered_cols), with = FALSE])
# saveRDS(o_colnames, "o_colnames.RData")

# d_colnames <- colnames(data[, eval(date_cols), with = FALSE])
# saveRDS(d_colnames, "d_colnames.RData")

SetClassData <- function(data){
  setwd("~/RScripts") # To set it to where the names are stored
  f_colnames <- quote(readRDS("f_colnames.RData"))
  o_colnames <- quote(readRDS("o_colnames.RData"))
  d_colnames <- quote(readRDS("d_colnames.RData"))

  data[, eval(f_colnames) := lapply(.SD, as.factor), .SDcols = eval(f_colnames)]
  data[, eval(o_colnames) := lapply(.SD, as.ordered), .SDcols = eval(o_colnames)]
  data[, eval(d_colnames) := lapply(.SD, as.IDate), .SDcols = eval(d_colnames)]

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

# saveRDS(desc, "VariableDescriptionsforCodebook.RData")
# desc <- readRDS("VariableDescriptionsforCodebook.Rdata")

#desc2 <- desc[-date_cols]
#saveRDS(desc2, "VariableDescriptionsforCodebook-nodates.RData")

data_ds <- data[, !d_colnames, with = FALSE]
data_ds <- data.set(data_ds)


for (i in seq_along(desc2) ) description(data_ds[[i]]) <- desc2[i]

?labels

data[, lapply(.SD, class)]

str(data_ds)

c_no_lab           <- c(1)
c_difficult_lab    <- c(2)
c_binary_lab       <- c()
c_binary_lab_777   <- c()
c_grade_lab        <- c(8, 10)
c_grade_lab        <- c(9)
c_index_lab        <- c(3)
c_index_lab_777    <- c(4)
c_behavior_lab     <- c(5,)
c_behavior_lab_777 <- c(6, 7)

binary_lab = c("Absent" = 0, "Present" = 1, "Don't Know" = 888)
binary_lab_777 = c("Absent" = 0, "Present" = 1, "Not Applicable" = 777, "Don't know" = 888)
index_lab = c("Ascertained for first tumor" = 1, "Ascertained for second tumor" = 2,"Don't know" = 888)
behavior_lab = c("Invasive" = 1, "In-situ" = 2, "Don't know" = 888)
behavior_lab_777 = c("Invasive" = 1, "In-situ" = 2, "Not Applicable" = 777, "Don't know" = 888)
grade_lab = c("Well-differentiated" = 1, "Moderately differentiated" = 2, "Poorly/un-differentiated" = 3, "Don't Know" = 888)
grade_lab_777 = c("Well-differentiated" = 1, "Moderately differentiated" = 2, "Poorly/un-differentiated" = 3, "Not Applicable" = 777, "Don't Know" = 888)

labels(data_ds[[3]]) <- index_lab
labels(data_ds[[4]]) <- index_lab_777
labels(data_ds[[5]]) <- behavior_lab

summary(data_ds$data_ds.Grade2)

summary(data_ds$data_ds.Grade1)

str(data)
str(pheno_361)

dim(data[pheno_361])

dim(data)
dim(pheno_361)
### Combining with peno_361

pheno_361 <- data.table(pheno_361)
nrow(pheno_361)
nrow(data)
setkey(pheno_361, uniqueID)
setkey(data, uniqueID)

ll <- list(data, pheno_361)
vals <- unique(c(data$uniqueID, pheno_361$uniqueID))
data <- unique(data)

nrow(length(vals))
nrow(pheno_361)
nrow(unique(data))

in_risk_factor <- pheno_361[(pheno_361$uniqueID %nin% data$uniqueID)]

in_risk_factor[, status]
in_risk_factor
data$uniqueID == "ABCS-F2161"

print(pheno_361[eval(in_risk_factor), "study", with = FALSE], nrow = 178)



sum(data$uniqueID %nin% pheno_361$uniqueID)
pheno_361$uniqueID[6999]
pheno_361["ABCS-F2161"]
data[pheno_361[]]
pheno_361[data[]]
vals

unique_keys <- unique(c(data[, uniqueID], pheno_361[, uniqueID]))
data[pheno_361[(J(unique_keys))]]
pheno_361[pheno_361 == 888] <- NA
pheno_361$study <- as.factor(pheno_361$study)

data2 <- merge(as.data.frame(data), as.data.frame(pheno_361), all = TRUE)

saveRDS(data, "data.RData")
saveRDS(pheno_361, "pheno_361.RData")

data <- readRDS("data.Rdata")
pheno_361 <- readRDS("pheno_361.Rdata")


nrow(data2)
which(is.na(data2$study.x))

str(data2)

