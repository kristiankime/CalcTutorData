test.ftable.select <- function() {
  input <- data.table.row(c( "col1", "col2", "col3"),
                       list(     11,     21,    31),
                       list(     12,     22,    32),
                       list(     13,     23,    33))
  
  output <- ftable(input)$select(col1, col3)$dt
  
  expected <- data.table.row(c( "col1", "col3"),
                          list(     11,     31),
                          list(     12,     32),
                          list(     13,     33))
  
  checkEquals.data.table(output, expected)
}
