# Getting the packages we need
#install.packages("memisc", dependencies = TRUE)

library(Hmisc) # Hmisc could give us access to the database in theory, but I used RODBC
library(RODBC)      # Interaction with .sdb file
library(data.table) # Could be faster than ordinary dataframes
library(ggplot2)    # For graphs
library(scales)
#library(memisc) # Superseded by codebooks package
library(nnet)
install.packages("mtable")
install.packages("mtable", repos="http://R-Forge.R-project.org", dependencies = TRUE)
library(codebooks)
detach("package:Hmisc")
library(memisc)
install.packages("codebooks", "")
detach("package:memisc")
summary(data)
setwd("~/Data") # To set it to where the database is
data[, sum(Bilateral == 2, na.rm = TRUE), by = study]

?memisc

# In order to keep all of the things I've done, I leave this part in to show how
# the data was imported from Access originally. In order to reduce the time it
# takes to load the file and do all the changes, the current working data.table
# object is actually loaded from the .RData file. 

# Importing the Access database
# into R so we can use it 
 data <- FromAccess('BCAC_14012015.mdb', "BCAC_CaseData", c("888", "NA"), "uniqueID")

# data <- SetNAs(data, c(888, "8008-08-08"))
data <- SetToNA(data)
data <- SetClassData(data)


summary(data)

# saveRDS(data, "working.data.table.RData")

data <- data.table(readRDS("working.data.table.Rdata"))
summary(data)
test.data.table(data, verbose = TRUE)

################### Getting summary statistics #####################
summary(data) 
summary(data$uniqueID)
sum(duplicated(data$uniqueID))
data[, sum(duplicated(uniqueID)), by = study]

# 716 duplicates
sum(!duplicated(data$uniqueID))
# 184396 non-duplicated patients
nlevels(data$study)
# 93 Different studies
summary(data[, .N, by = study]$N)
qplot(x = data[, .N, by = study]$N)

# 93 - 16090 participants per study, mean 1990, median 1426
qdata <- data[sample(nrow(data), 100), , ]
qplot(as.vector(table(data$study)), xlab = "Number of participants", ylab = "Number of studies") +
  scale_x_log10() +
  scale_y_continuous()

# Index
# Not sure why there are 37,399 with 888 in Index_corr and 40,477 with 888 in Index. 
sum(data$Index_corr == 888, na.rm = TRUE)
sum(data$Index == 888, na.rm = TRUE)

# model <- glm((data$Index_corr == 888) ~ data$study, family = "binomial")
# Some studies have no identification here and others have only a few that are missing.

# Since we're interested in CBC, let's see how many show up based on index = 2

sum(data$Index_corr == 2, na.rm = TRUE)

# The corrected Index shows 2,321 incidences of second tumor, but not sure what that means. Could be 2nd primary or CBC?
# Let's see what we can get from the ones that are indexed as 2 for 'ascertained for second tumor'
studies_w_ind2 <- levels(droplevels(data[data$Index_corr == 2, ])$study)
cbc_part <- data[data$study %in% studies_w_ind2, ]



# So 61 studies show no "index 2" which could mean they don't cover contralateral breast cancer in their database at all
# I'm not sure what that means. 6 have one incident, 1 has 3, and from there it goes up to reasonable levels.

qplot(cbc_part$study, fill = factor(cbc_part$Index_corr)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

qplot(cbc_part$study, fill = factor(cbc_part$Behaviour2)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# So here it's clear that even in the very large studies, there's relatively little CBC recorded
# We can also go at it a different way, using Behavior

studies_w_bh2 <- levels(droplevels(data[data$Behaviour2 %in% c(1, 2), ])$study)
cbc_part <- data[data$study %in% studies_w_bh2, ]
cbc_part$bigstudy <- 0
cbc_part[cbc_part$study %in% c("ABCS", "CGPS", "SEARCH", "SEBCS", "LMBC", "BBCC", "BBCS"), "bigstudy"] = 1

qplot(cbc_part$study, fill = factor(cbc_part$Index_corr)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

cbc_part_cond <- cbc_part[, c(2, 4, 6, 177), with = FALSE]

ggplot(data = cbc_part_cond, aes(x = factor(study), fill = factor(Behaviour2))) +
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  facet_wrap( ~ bigstudy, scales = "free", shrink = TRUE)

ggplot(data = cbc_part_cond[cbc_part_cond$Behaviour2 %in% c(1, 2), ], aes(x = study, fill = factor(Behaviour2))) +
  geom_bar(as.table = TRUE) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

ggplot(data = cbc_part_cond, aes(x = factor(Behaviour2)))+
  geom_bar()

###### Bilateral?

sum(data$Bilateral == 1, na.rm = TRUE)
sum(data$Bilateral == 2, na.rm = TRUE)
sum(data$Behaviour2 %in% c(1, 2))

# So in theory all these people had contralateral breast cancer, but there are quite a lot scored with
# no second tumor or don't know. ABCS is the worst offender
ggplot(data = data[data$Bilateral == 1, ], aes(x = study, fill = factor(Behaviour2))) +
  geom_bar(as.table = TRUE) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 


data[, sum(Bilateral == 1, na.rm = TRUE), by = study ]

sum(is.na(data))
sum(!is.na(data))
data$YearsToRelapse

###### Looking at completeness #######
### Data must be in data.table format ###


data_test[, sum(!is.na(ER_status1)) / (sum(!is.na(ER_status1)) + sum(is.na(ER_status1))), by = study]

### Data Frame - What is Where? for which studies have which features
wiw

