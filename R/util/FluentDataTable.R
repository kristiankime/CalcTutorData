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
      data <- dt[eval(expr)]
      ftable(data)
    },
    
    # usage: pass in something that will get wrapped in a list before evaluation
    # example: data$select(col1, col2)
    select = function(...) {
      expr <- substitute(list(...))
      data <- dt[, eval(expr)]
      ftable(data)
    },
    
    # usage: passed through raw 
    # example: data$select(list(col1, col2))
    selectR = function(statement) {
      expr <- substitute(statement)
      data <- dt[, eval(expr)]
      ftable(data)
    },
    
    # usage: Pass in quoted data that will get evaled
    # example: foo <- quote(list(col1, col2)); data$select(foo);
    selectE = function(expr) {
      data <- dt[, eval(expr)]
      ftable(data)
    },
    
    union = function(otherTable, use.names=fill, fill=TRUE) {
      data <- rbindlist(list(dt, otherTable), use.names=use.names, fill=fill)
      ftable(data)
    },
    
    merge = function(otherTable, by = NULL, all = FALSE, all.x = all, all.y = all, suffixes = c(".x", ".y"), allow.cartesian=getOption("datatable.allow.cartesian"), ...) {
      data <- merge(x = dt, y = otherTable, by = by, all = all, all.x = all.x, all.y = all.y, suffixes = suffixes, allow.cartesian=allow.cartesian, ...)
      ftable(data)
    },
    
    leftJoin = function(otherTable, by = NULL, suffixes = c(".x", ".y"), allow.cartesian=getOption("datatable.allow.cartesian"), ...) {
      data <- merge(x = dt, y = otherTable, by = by, all.x =TRUE, suffixes = suffixes, allow.cartesian=allow.cartesian, ...)
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

# data <- data.table(col1 = 1:3, col2 = 4:6, col3 = 7:9, col4 = 10:12)
# fdt <- ftable(data)
# fdt$filter( col1 == 1 & col2 == 4 )
# fdt$select(col1, col2)

