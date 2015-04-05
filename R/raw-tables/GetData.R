
TableRFormat <- function(name, ...) {
  ret <- list(name = name, updates=c(...))
  class(ret) <- "TableRFormat"
  return(ret)
}

calcTutorTables <- list(
  TableRFormat("application_users"),
  TableRFormat("courses"),
  TableRFormat("courses_2_quizzes"),
  TableRFormat("derivative_answers", function(d){d[,correct:=as.logical(correct)]}),
  TableRFormat("derivative_questions"),
  TableRFormat("games"),    
  TableRFormat("organizations"),
  TableRFormat("quizzes"),
  TableRFormat("secure_social_logins"),
  TableRFormat("tangent_answers", function(d){d[,correct:=as.logical(correct)]}),
  TableRFormat("tangent_questions"),
  TableRFormat("users_2_courses")
)             

RawTableFile <- function(table) { paste0(dataRawTables, "/", table,".rds") }

CalcTutorData.PostgreSQL2File <- function() {
  GetDataTable <- function(table) { data.table(sqldf(paste0("SELECT * FROM ", table))) }
  
  foreach(table = calcTutorTables, .combine=c) %do% {
    tableName <- table$name
    data <- GetDataTable(tableName)
    foreach(func = table$updates) %do% {
      func(data)
    }
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

