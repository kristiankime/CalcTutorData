# Data so examples will run
data = data.table(col1 = 1:3, col2 = 4:6, col3 = 7:9, col4 = 10:12)

data2 = data.table(col1 = 1:3, col2 = 4:6, col5 = 7:9, col6 = 10:12)

col1Name <- "col1"
col2Name <- "col2"
col3Name <- "col3"
col4Name <- "col4"

newColName  <- "newCol"
newCol1Name <- "newCol1"
newCol2Name <- "newCol2"
newCol3Name <- "newCol3"

one   <- 1
two   <- 2
three <- 3
four  <- 4

func <- function(a) { a }

# ==========================================
# Extract elements
# ==========================================
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/Extract.data.frame.html

data[[1]] # extract a column
data[2,1] # extract a value

# ==========================================
# Select
# ==========================================

# Number
data[, 2, with=FALSE]

# Number Multiple
data[, 1:2, with=FALSE]
data[, c(1,3), with=FALSE]

# Indirect Number
data[, two, with=FALSE]

# Number Multiple
data[, c(one, two), with=FALSE]

# Direct Name
data[, col1, with=TRUE]

# Direct Name Multiple
data[, list(col2, col3), with=TRUE]

# Indirect Name
data[, col1Name, with=FALSE]
data[, "col1", with=FALSE]
data[, list(get("col1")), with=TRUE]
data[, list(col1=get("col1")), with=TRUE]
data[, .(col1=get("col1")), with=TRUE]


# Indirect Name Multiple
data[, c(col2Name, col3Name), with=FALSE]
data[, c("col2", "col3"), with=FALSE]

foo <- quote(list(col1=get("col1")))
data[, eval(foo)]

# ==========================================
# Group By
# ==========================================

# Direct
data[, newCol:=func(col1), by=col1]

# Direct Multiple
data[, list(newCol1=func(col3), newCol2=func(col4)), by=list(col1, col2)]

# Indirect

# Indirect Multiple

# Special Characters
# .N will give you the number of number of rows in each group.
data[, list(count=.N), by=list(col1, col2)]

# ==========================================
# Assign
# ==========================================

# Indirect Name
data[, newColName:=4:6, with=FALSE]

# Direct Name
data[, newCol:=4:6]

# Direct Name with spaces in the name
data[, 'new column':=4:6]

# ==========================================
# Merge / Join
# ==========================================

# on shared key columns
merge(data, data2)

# Explicit by columns
merge(data, data2, by=c("col1", "col2"))

# ==========================================
# Sort / Order By
# ==========================================
# Increasing
data[order(col1, col2)]

# Decreasing
data[order(-rank(col1), col2)]

#setorder(data, "col3", "col2", "col1", na.last=TRUE)
#setorderv(data, c("col3", "col2", "col1"), na.last=TRUE)


# ==========================================
# Change Column Order (In place) / Reorder Columns
# ==========================================
# setcolorder(data, c("col4", "col3", "col2", "col1")) # will fail it all columns aren't listed

# ==========================================
# Untion / Concantenate
# ==========================================

rbindlist(list(data, data))

# ==========================================
# Write to File / CSV / 
# ==========================================

# ---- CSV ----
# write.table
# write.csv

# ---- RDS ----
# saveRDS