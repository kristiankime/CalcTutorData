
user.math10A.dt <- {
  userInfo.dt <- ftable(secure_social_logins)$select(user_id=id, name=full_name, email=email)$dt
  math10AStudent.dt <- ftable(data.table(read.csv(HWTableFile("CalcTutor Math 10a Users"))))$select(math10a, email)$dt
  user.math10A.dt <- ftable(userInfo.dt)$merge(math10AStudent.dt, by=c("email"))$dt
}

