test.ftable.select.column_names <- function() {
  output <- ftable(data.table(col1=1:3, col2=4:6, col3=7:9))$select(col1, col3)$dt
  checkEquals.data.table(output, data.table(col1=1:3, col3=7:9))
}

test.ftable.select.renaming <- function() {
  output <- ftable(data.table(col1=1:3, col2=4:6, col3=7:9))$select(new1=col1, new2=col3)$dt
  checkEquals.data.table(output, data.table(new1=1:3, new2=7:9))
}

test.ftable.selectR.with_strings <- function() {
  output <- ftable(data.table(col1=1:3, col2=4:6, col3=7:9))$selectR(list(col1, col3))$dt
  checkEquals.data.table(output, data.table(col1=1:3, col3=7:9))
}

test.ftable.selectE.with_strings <- function() {
  output <- ftable(data.table(col1=1:3, col2=4:6, col3=7:9))$selectE(quote(list(col1=get("col1"), col3=get("col3"))))$dt
  checkEquals.data.table(output, data.table(col1=1:3, col3=7:9))
}



