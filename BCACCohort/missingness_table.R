MakeMissingnessTable <- function() {
    wiw.m <- data.table(matrix(nrow = 10, ncol = 91 ))
    wiw.m[, 2:91 := lapply(.SD, as.numeric), .SDcols = 2:91]
    setattr(wiw.m, 'names',
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

    wiw.m$Study <- c("BCAC", "BOSOM", "ABCS", "Erasmus BCS", "Origo", "TTP", "HEBON", "CIMBA", "IBCCS", "NKR")
    setkey(wiw.m, Study)
    wiw.m
}

GetCBCSubset <- function(DT) {
    studies_w_cbc <- DT[, sum(Bilateral == 1, na.rm = TRUE), by = study][V1 > 0]$study
    subset(DT, study %in% studies_w_cbc)
}

GetMissingnessVector <- function(DT) {
    PercMissing <- function(column){
        sum(is.na(column))/length(column)
    }
    apply(DT, 2, PercMissing)
}

SetValuesforBCAC <- function(wiw.m, missing.in.cbc) {
    wiw.m["BCAC", N := 91587,]
    wiw.m["BCAC", N_CBC := 6884,]
    wiw.m["BCAC", Deg1Rel := missing.in.cbc["famHist"], ]
    wiw.m["BCAC", Deg2Rel := missing.in.cbc["famHist"], ]
    wiw.m["BCAC", BMI := missing.in.cbc["BMI"], ]
    wiw.m["BCAC", OralBC := missing.in.cbc["OCEver"], ]
    wiw.m["BCAC", OralBC_bd := missing.in.cbc["OCStartAge"], ]
    wiw.m["BCAC", OralBC_ed := missing.in.cbc["OCStopAge"], ]
    wiw.m["BCAC", MenarcheAge := missing.in.cbc["ageMenarche"], ]
    wiw.m["BCAC", Parity := missing.in.cbc["parity"], ]
    wiw.m["BCAC", Menopausal := missing.in.cbc["menoStat"], ]
    wiw.m["BCAC", Status := missing.in.cbc["VitalStatus"], ]
    wiw.m["BCAC", Status_ed := missing.in.cbc["DateLastFU"], ]
    wiw.m["BCAC", CBC := missing.in.cbc["Bilateral"], ]
    wiw.m["BCAC", Diag_d := missing.in.cbc["DateDiagIndex"], ]
    wiw.m["BCAC", TumorSize := missing.in.cbc["SizeIndex"], ]
    wiw.m["BCAC", Nodes := missing.in.cbc["NodeStatusIndex"], ]
    wiw.m["BCAC", Nodes_Number := missing.in.cbc["NodesIndex"], ]
    wiw.m["BCAC", Nodes_PositiveSN := missing.in.cbc["NodesIndex"], ]
    wiw.m["BCAC", Metastasis := missing.in.cbc["MIndex_status"], ]
    wiw.m["BCAC", Bilateral := missing.in.cbc["Bilateral"], ]
    wiw.m["BCAC", ERStatus := missing.in.cbc["ER_statusIndex"], ]
    wiw.m["BCAC", PRStatus := missing.in.cbc["PR_statusIndex"], ]
    wiw.m["BCAC", HER2Status := missing.in.cbc["HER2_statusIndex"], ]
    wiw.m["BCAC", Morphology := missing.in.cbc["MorphologygroupIndex_corr"], ]
    wiw.m["BCAC", DCIS := missing.in.cbc["BehaviourIndex"], ]
    wiw.m["BCAC", Surgery := missing.in.cbc["Surgery"], ]
    wiw.m["BCAC", Surgery_Type := missing.in.cbc["Surgery"], ]
    wiw.m["BCAC", Radiotherapy := missing.in.cbc["Radiation"], ]
    wiw.m["BCAC", Radiotherapy_Site := missing.in.cbc["Radiation"], ]
    wiw.m["BCAC", Chemotherapy := missing.in.cbc["Chemo_adjuvant"], ]
    wiw.m["BCAC", Chemotherapy_bd := missing.in.cbc["Chemo_adjuvant_start_known"], ]
    wiw.m["BCAC", Chemotherapy_ed := missing.in.cbc["Chemo_adjuvant_stop_known"], ]
    wiw.m["BCAC", Chemotherapy_Adj := missing.in.cbc["Chemo_adjuvant"], ]
    wiw.m["BCAC", Chemotherapy_Neo := missing.in.cbc["Chemo_neoadjuvant"], ]
    wiw.m["BCAC", Chemotherapy_Type := missing.in.cbc["Chemo_adjuvant_type"], ]
    wiw.m["BCAC", Chemotherapy_number := missing.in.cbc["Chemo_adjuvant_dose"], ]
    wiw.m["BCAC", HormonalTherapy := missing.in.cbc["Horm_adjuvant"], ]
    wiw.m["BCAC", HormonalTherapy_ed := missing.in.cbc["Horm_adjuvant_stop_known"], ]
    wiw.m["BCAC", HormonalTherapy_bd := missing.in.cbc["Horm_adjuvant_start_known"], ]
    wiw.m["BCAC", HormonalTherapy_Type := missing.in.cbc["Horm_adjuvant_type"], ]
    wiw.m["BCAC", Monoclonal := missing.in.cbc["Trastuzumab_adjuvant"], ]
    wiw.m["BCAC", Monoclonal_bd := missing.in.cbc["Trastuzumab_adjuvant_start_known"], ]
    wiw.m["BCAC", Monoclonal_ed := missing.in.cbc["Trastuzumab_adjuvant_stop_known"], ]
    wiw.m["BCAC", FU_Recurrence := missing.in.cbc["Locoregional_relapse"], ]
    wiw.m["BCAC", FU_Recurrence_d := missing.in.cbc["Date_Locoregional_relapse_known"], ]
    wiw.m["BCAC", FU_Recurrence_Site := missing.in.cbc["Locoregional_relapse"], ]
    wiw.m["BCAC", FU_Metastasis := missing.in.cbc["Distant_metastasis_relapse"], ]
    wiw.m["BCAC", FU_Metastasis_d := missing.in.cbc["Date_Distant_metastasis_relapse_known"], ]

}

wiw.m <- MakeMissingnessTable()
subset.DT <- GetCBCSubset(data2)
Bcac.Cbc.Missing <- GetMissingnessVector(subset.DT)
wiw.m <- SetValuesforBCAC(wiw.m, Bcac.Cbc.Missing)
