
TableRFormat <- function(name, ...) {
  ret <- list(name = name, updates=c(...))
  class(ret) <- "TableRFormat"
  return(ret)
}

calcTutorTables <- list(
  TableRFormat("application_users"),
  TableRFormat("courses"),
  TableRFormat("courses_2_quizzes"),
  TableRFormat("derivative_answers"),
  TableRFormat("derivative_questions"),
  TableRFormat("games"),    
  TableRFormat("organizations"),
  TableRFormat("quizzes"),
  TableRFormat("secure_social_logins"),
  TableRFormat("tangent_answers"),
  TableRFormat("tangent_questions"),
  TableRFormat("users_2_courses"),
)             

RawTableFile <- function(table) { paste0(dataRawTables, "/", table,".rds") }

CalcTutorData.PostgreSQL2File <- function() {
  GetDataTable <- function(table) { sqldf(paste0("SELECT * FROM ", table)) }
  
  foreach(table = calcTutorTables, .combine=c) %do% {
    tableName <- table$name
    data <- GetDataTable(tableName)
    saveRDS(data, file=RawTableFile(tableName))
    paste0(tableName, " saved")
  }
}

CalcTutorData.LoadFromFile <- function() {
  foreach(table = calcTutorTables, .combine=c) %do% {
    tableName <- table$name
    data <- readRDS(RawTableFile(tableName))
    assign(tableName, data, envir=.GlobalEnv)
    paste0(tableName, " loaded")
  }
}

