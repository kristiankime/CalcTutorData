test.data.table.row_works <- function() {
  data <- data.table.row(c( "col1", "col2", "col3"),
                          list(     1,     4,    7),
                          list(     2,     5,    8),
                          list(     3,     6,    9))
  
  expected <- data.table(col1=1:3, col2=4:6, col3=7:9)
  
  checkEquals.data.table(data, expected)
}



