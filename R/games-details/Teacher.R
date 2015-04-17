

game.teacher.dt <- {
  user.main <- ftable(user.math10A.dt)$select(user_id=user_id, user_name=name, user_math10a=math10a)$dt
  user.partner <- ftable(user.math10A.dt)$select(partner_id=user_id, partner_name=name, partner_math10a=math10a)$dt
  game.math10a.dt <- ftable(game.summary.dt)$merge(user.main, by=("user_id"))$merge(user.partner, by=("partner_id"))$dt

  questions.user <- ftable(questions.summary.dt)$select(question_user_id=user_id, question_id, user_quiz_id=quiz_id, question_difficulty, type)$filter(!is.na(user_quiz_id))$dt

  setkey(questions.user, user_quiz_id)
  setkey(game.math10a.dt, user_quiz_id)
  game.teacher.questions.dt <- game.math10a.dt[questions.user, allow.cartesian=TRUE]
}

game.onlyMath10a.dt <- game.math10a.dt[user_math10a == T & partner_math10a == T]

saveRDS(game.math10a.dt, file=GamesTableFileRaw("games.teacher"))
write.csv(game.math10a.dt, file=GamesTableFileCSV("games.teacher"))

GamesTableFile()