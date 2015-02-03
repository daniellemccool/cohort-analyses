source("~/R/cohort-analyses/Shared/what_is_where_functions.R")


# sum(!duplicated(data$uniqueID)) # 183396
# Only 91587 from studies with some CBC
wiw["BCAC", N := 91587]
setkey(wiw, Study)
#data[, sum(!duplicated(uniqueID), na.rm = TRUE), by = Bilateral] #6884 incidences of CBC
wiw["BCAC", N_CBC := 6884]

names <- names(wiw.m["BCAC", wiw.m["BCAC", !is.na(.SD), ], with = FALSE])

wiw["BCAC", names[-c(1:3)] := 1L, with = FALSE]

names2 <- names(wiw.m["BCAC", wiw.m["BCAC", is.na(.SD), ], with = FALSE])

wiw["BCAC", names2[c(1:5, 9:14)] := 2L, with = FALSE]
wiw["BCAC", names2[-c(1:5, 9:14)] := 4L, with = FALSE]


