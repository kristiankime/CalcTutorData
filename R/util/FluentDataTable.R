# TODO http://r-pkgs.had.co.nz/man.html

# http://stackoverflow.com/questions/4682709/how-to-write-an-r-function-that-evaluates-an-expression-within-a-data-frame

ftable <- function(dt) {
  if(!is.data.table(dt)) {
    stop("data was not a data.table")
  }
  ret <- list(

    # usage: fdt$filter(col1 == 1 & col2 == 4)
    filter = function(filters) {
      expr <- substitute(filters)
      print(expr)
      data <- dt[eval(expr)]
      ftable(data)
    },
    
    # usage: fdt$select(col1, col2)
    select = function(...) {
      expr <- substitute(list(...))
      data <- dt[, eval(expr), with=TRUE]
      ftable(data)
    },
    
    selectNoList = function(columns) {
      expr <- substitute(columns)
      data <- dt[, eval(expr), with=TRUE]
      ftable(data)
    },
     
    union = function(otherTable, use.names=fill, fill=TRUE) {
      data <- rbindlist(list(dt, otherTable), use.names=use.names, fill=fill)
      ftable(data)
    },
    
    dt = dt
    )
  class(ret) <- "ftable"
  return(ret)
}

# http://abhishek-tiwari.com/hacking/class-and-objects-in-r-s3-style (see Extending the Internal generics)
print.ftable <- function(x, ...) {
  print(x$dt, ...)
}

data <- data.table(col1 = 1:3, col2 = 4:6, col3 = 7:9, col4 = 10:12)
fdt <- ftable(data)
fdt$filter( col1 == 1 & col2 == 4 )
fdt$select(col1, col2)

