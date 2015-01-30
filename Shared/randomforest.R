install.packages("randomForest")
library(randomForest)
rfNews()
data2 <- data
data2[data2 == 777] <- NA


randomForest((Bilateral == 2) ~ )

data(iris)
set.seed(71)
iris.rf <- randomForest(Species ~ ., data = iris, importance = TRUE, proximity = TRUE)
print(iris.rf)

round(importance(iris.rf), 2)

iris.mds <- cmdscale(1 - iris.rf$proximity, eig = TRUE)
op <- par(pty = "s")
pairs(cbind(iris[, 1:4], iris.mds$points), cex = 0.6, gap = 0,
      col = c("red", "green", "blue")[as.numeric(iris$Species)],
      main = "Iris Data: Predictors and MDS of Proximity Based on RandomForest")
par(op)
print(iris.mds$GOF)

cbc.rf <- randomForest(Bilateral ~ AgeDiag1 + CK56_status1 + Grade1 + Nodes1 + PR_status1, data = data, importance = TRUE, proximity = TRUE, na.action = na.omit  )
round(importance(cbc.rf), 2)

CbcCols <- data[, sum(!is.na(Bilateral)), by = study][V1!=0]$study
CbcCols <- droplevels(CbcCols)

data2 <- data[study %in% CbcCols]

data == 777

data[, .N, by = .SD]

data[, , by = study]
data[777]
data$Bilateral <- droplevels(data$Bilateral)

ls(data)
?data.table
