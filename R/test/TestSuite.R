# See http://www.johnmyleswhite.com/notebook/2010/08/17/unit-testing-in-r-the-bare-minimum/
library('RUnit')

test.suite <- defineTestSuite("example", dirs=c("R/test"), testFileRegexp = "Test-")

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)