checkEquals.data.table <- function(table, expected){
  checkEquals(colnames(table), colnames(expected), " column names were different")
  for(colName in colnames(table)) {
    # col1 <- table[, colName]
    # col2 <- expected[, colName]
    col1 <- with(table, get(colName))
    col2 <- with(expected, get(colName))
    #print(col1)
    #print(col2)
    # checkEquals(col1, col2, msg=paste("The data in column=[", colName ,"] was different col1=[", col1,"] col2=[", col2,"]"))
    checkEquals(col1, col2, msg=paste0(" col=", colName))
  }
  T
}