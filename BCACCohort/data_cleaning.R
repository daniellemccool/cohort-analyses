
data[data == 888] <- NA
data_test[data_test == "8000-08-08"] <- NA

data_test[, 2:20 := lapply(.SD, as.factor), .SDcols = 2:20]

data_test[, c(21:23, 33:37) := lapply(.SD, as.factor), .SDcols = c(21:23, 33:37)]
data_test[, c(27:32) := lapply(.SD, as.ordered), .SDcols = 27:32]

data_test[, c(41:49, 52:57, 60) := lapply(.SD, as.factor), .SDcols = c(41:49, 52:57, 60)]

data_test[, c(61:65, 67:72, 76:80) := lapply(.SD, as.factor), .SDcols = c(61:65, 67:72, 76:80)]
data_test[, c(66, 73, 74) := lapply(.SD, as.ordered), .SDcols = c(66, 73, 74)]
data <- data_test

summary(data_test[, 81:100, with = FALSE])
data_test[, c(81, 85:88) := lapply(.SD, as.factor), .SDcols = c()]
data_test[, c(82:83) := lapply(.SD, as.ordered), .SDcols = c()]

summary(as.factor(data_test$Chemo_adjuvant_start))

save(data, file = "working.data.table.RData")
rm(list = ls())
load("working.data.table.RData")
gc()
memory.size(max = TRUE)
memory.limit(size = 4095)
memory.limit()
