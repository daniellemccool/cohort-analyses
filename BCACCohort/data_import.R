FromAccess <- function (file_path, database_name, na_strings, datatable_key) {
  d       <- file.path(file_path)     # This is telling it what the path to the file is
  channel <- odbcConnectAccess2007(d)           # This function tells it how to access it
  data    <- sqlFetch(channel, database_name, na.strings = na_strings ) # This gets the table from the database
  data    <- data.table(data)
  setkeyv(data, datatable_key)
    
  data
}