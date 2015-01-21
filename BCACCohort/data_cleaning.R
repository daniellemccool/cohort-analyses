
data[data == 888] <- NA
data[data == "8000-08-08"] <- NA

data_test <- data

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


f_colnames <- quote(readRDS("f_colnames.RData"))
o_colnames <- quote(readRDS("o_colnames.RData"))

data_test[, eval(f_colnames) := lapply(.SD, as.factor), .SDcols = eval(f_colnames)]
data_test[, eval(ordered_cols) := lapply(.SD, as.ordered), .SDcols = eval(ordered_cols)]


data <- data_test
saveRDS(data_test, "working.data.table.RData")



