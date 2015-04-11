
data.table.rbind <- function(...){ rbindlist(list(...)) }

data.table.row <- function(colnames, ...) {
  foreach(v = list(...), .combine=data.table.rbind) %do% {
    names(v) <- colnames
    v
  }
}
