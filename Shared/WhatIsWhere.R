library(data.table)

### Data Frame - What is Where? for which studies have which features
wiw <- data.table(matrix(nrow = 10, ncol = 91 ))
setattr(wiw, 'names',
        c("Study", "N", "N_CBC", "Birthdate", "BRCA1",
          "BRCA1_d", "BRCA2", "BRCA2_d",  "CHEK2", "CHEK2_d", "SNP", "Deg1Rel",
          "Deg2Rel", "BMI", "OralBC", "OralBC_bd", "OralBC_ed", "MenarcheAge",
          "FirstPregAge", "Parity", "Menopausal", "Smoker", "Sm_PackYears", "Alcohol", 
          "Al_DrinksPerWeek", "Ethnicity", "BreastDensity", "Status", "Status_ed",
          "BRRM", "BRRM_d", "RRSO", "RRSO_d", "Number_BC", "CBC", "Diag_d", "SideBC", 
          "TumorSize", "Nodes", "Nodes_PositiveSN", "Nodes_Axillary", "Nodes_Number",
          "Metastasis", "Metastasis_Site", "Multifocal", "Bilateral", "ERStatus", 
          "PRStatus", "HER2Status", "Morphology", "DCIS", "Surgery", "Surgery_Type",
          "Surgery_d", "Radiotherapy", "Radiotherapy_bd", "Radiotherapy_ed",
          "Radiotherapy_Adj", "Radiotherapy_Neo", "Radiotherapy_Site", "Chemotherapy",
          "Chemotherapy_bd", "Chemotherapy_ed", "Chemotherapy_Adj", "Chemotherapy_Neo",
          "Chemotherapy_Type", "Chemotherapy_number", "HormonalTherapy", 
          "HormonalTherapy_bd", "HormonalTherapy_ed", "HormonalTherapy_Type",
          "Monoclonal", "Monoclonal_bd", "Monoclonal_ed", "Monoclonal_Type", "CRRM",
          "CRRM_d", "FU_Recurrence", "FU_Recurrence_d", "FU_Recurrence_Site", 
          "FU_Recurrence_Therapy", "FU_Metastasis", "FU_Metastasis_d",
          "FU_Metastasis_Site", "FU_Metastasis_Therapy", "FU_OtherMalig",
          "FU_OtherMalig_Type", "FU_OtherMalig_d", "FU_OtherMalig_Site",
          "FU_OtherMalig_Stage",
          "FU_OtherMalig_Therapy"))

wiw$Study <- c("BCAC", "BOSOM", "ABCS", "Erasmus BCS", "Origo", "TTP", "HEBON", "CIMBA", "IBCCS", "NKR")
setkey(wiw, "Study")

wiw[, 4:91 := lapply(.SD, factor, levels = c(0, 1, 2, 3), labels = c("Currently Have", "Must Request", "Limited Information", "Not available"  )), .SDcols = 4:91]


wiw[, N:=as.numeric(N)]
wiw[, N_CBC:=as.numeric(N_CBC)]

# sum(!duplicated(data$uniqueID)) # 183396
# Only 91587 from studies with some CBC
wiw["BCAC", N := 91587]

#data[, sum(!duplicated(uniqueID), na.rm = TRUE), by = Bilateral] #6884 incidences of CBC
wiw["BCAC", N_CBC := 6884]


wiw["BCAC", `:=`(Birthdate = 2L, BRCA1 = 2L, BRCA1_d = 2L, BRCA2 = 2L, BRCA2_d = 2L)]

wiw["BCAC", `:=`(CHEK2 = 4L, CHEK2_d = 4L, SNP = 4L)]

wiw["BCAC", `:=`(Deg1Rel = 1L, Deg2Rel = 1L)]

data2 <- data.table(data2)

data2[, (sum(is.na(.SD))/.N), ]

apply(data2, 2, perc_missing)

perc_missing <- function(column){
  sum(is.na(column))/length(column)
}

saveRDS(data2, "data2.RData")
data2 <- readRDS("data2.RData")
