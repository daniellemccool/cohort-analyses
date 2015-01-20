
data[data == 888] <- NA

data_test[, 2:20 := lapply(.SD, as.factor), .SDcols = 2:20]

data_test[, c(21:23, 33:37) := lapply(.SD, as.factor), .SDcols = c(21:23, 33:37)]
data_test[, c(27:32) := lapply(.SD, as.ordered), .SDcols = 27:32]
data <- data_test

summary(data_test[, 41:60, with = FALSE])
data_test[, c() := lapply(.SD, as.factor), .SDcols = c()]
data_test[, c() := lapply(.SD, as.ordered), .SDcols = c()]

