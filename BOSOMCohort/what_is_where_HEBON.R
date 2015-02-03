
in.codebook <- c(3:10, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
    25, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 39, 40, 41,
    42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55,
    60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 76,
    77, 78, 79, 80, 82, 83, 84, 86, 87, 88, 89 )

wiw["HEBON", names(wiw)[in.codebook] := 2L, with = FALSE]
wiw["HEBON", names(wiw)[1:91 %nin% in.codebook][-c(1, 2)] := 4L, with = FALSE]


wiw["HEBON", N := 10000]
wiw["HEBON", N_CBC := NA]

write.csv(wiw[c("HEBON", "BCAC")], "what_is_where_entered.csv")