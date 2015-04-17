
UsersMath10A <- function() {
  userInfo <- ftable(db.secure.social.logins.dt)$select(user_id=id, name=full_name, email=email)$dt
  math10AStudent <- ftable(data.table(read.csv(HWTableFile("CalcTutor Math 10a Users"))))$select(math10a, email)$dt
  user.math10A <- ftable(userInfo)$merge(math10AStudent, by=c("email"))$dt
}

