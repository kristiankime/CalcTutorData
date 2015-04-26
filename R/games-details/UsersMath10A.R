
UsersMath10A <- function() {
  userInfo <- ftable(db.secure.social.logins.dt)$select(user_id=id, name=full_name, email=email)$dt
  math10AStudent <- ftable(data.table(read.csv(HWTableFile("CalcTutor Math 10a Users"))))$select(math10a, email)$dt
  user.math10A <- ftable(userInfo)$merge(math10AStudent, by=c("email"))$dt
}

UsersMath10AWithExams <- function() {
  userInfo <- ftable(db.secure.social.logins.dt)$select(user_id=id, name=full_name, email=email)$dt
  math10AStudent <- ftable(data.table(read.csv(HWTableFile("CalcTutor Math 10a Users"))))$select(math10a, email, pre_test=pre.test, exam1=exam.1, exam2=exam.2)$dt
  user.math10A <- ftable(userInfo)$merge(math10AStudent, by=c("email"))$dt
}