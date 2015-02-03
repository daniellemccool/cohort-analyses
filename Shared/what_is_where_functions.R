MakeWiwTable <- function() {
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
}
