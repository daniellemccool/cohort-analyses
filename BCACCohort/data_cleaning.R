
data[data == 888] <- NA
data[data == "8000-08-08"] <- NA

data_test <- data

factor_cols <- quote(c(2:20, 21:23, 33:37, 41:49, 52:57, 60, 61:65, 67:72, 76:80, 81, 85:88,
                 91, 93:99, 101:104, 106, 108, 110, 112, 114, 116:120, 121:124, 127,
                 129:135, 137, 141, 147, 153, 155, 157, 159, 161, 164:167, 169:170,
                 172, 175:176))

ordered_cols <- quote(c(27:32, 66, 73, 74, 82:83, 136, 139:140, 143:146))


data_test[, eval(factor_cols) := lapply(.SD, as.factor), .SDcols = eval(factor_cols)]
data_test[, eval(ordered_cols) := lapply(.SD, as.ordered), .SDcols = eval(ordered_cols)]

data_test[, 2:20 := lapply(.SD, as.factor), .SDcols = 2:20]

data_test[, c(21:23, 33:37) := lapply(.SD, as.factor), .SDcols = c(21:23, 33:37)]
data_test[, c(27:32) := lapply(.SD, as.ordered), .SDcols = 27:32]

data_test[, c(41:49, 52:57, 60) := lapply(.SD, as.factor), .SDcols = c(41:49, 52:57, 60)]

data_test[, c(61:65, 67:72, 76:80) := lapply(.SD, as.factor), .SDcols = c(61:65, 67:72, 76:80)]
data_test[, c(66, 73, 74) := lapply(.SD, as.ordered), .SDcols = c(66, 73, 74)]

data_test[, c(81, 85:88, 91, 93:99) := lapply(.SD, as.factor), .SDcols = c(81, 85:88, 91, 93:99)]
data_test[, c(82:83) := lapply(.SD, as.ordered), .SDcols = c(82:83)]

data_test[, c(101:104, 106, 108, 110, 112, 114, 116:120) := lapply(.SD, as.factor), .SDcols = c(101:104, 106, 108, 110, 112, 114, 116:120)]

data_test[, c(121:124, 127, 129:135, 137) := lapply(.SD, as.factor), .SDcols = c(121:124, 127, 129:135, 137)]
data_test[, c(136, 139:140) := lapply(.SD, as.ordered), .SDcols = c(136, 139:140)]

data_test[, c(141, 147, 153, 155, 157, 159) := lapply(.SD, as.factor), .SDcols = c(141, 147, 153, 155, 157, 159)]
data_test[, c(143:146) := lapply(.SD, as.ordered), .SDcols = c(143:146)]


summary(data_test[, 161:176, with = FALSE])
data_test[, c(161, 164:167, 169:170, 172, 175:176) := lapply(.SD, as.factor), .SDcols = c(161, 164:167, 169:170, 172, 175:176)]

data <- data_test
saveRDS(data_test, "working.data.table.RData")




