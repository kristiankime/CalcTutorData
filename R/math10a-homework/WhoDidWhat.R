

WhoAnswered <- {
  All.owner.dt <- application_users[,list(owner=user_id),with=TRUE]

  # Create a table of (owner, question_id, quiz_id) for all derivative questions / users
  All.question.dt <-  derivative_questions[, list(question_id=id), with=TRUE]
  All.owner_question.dt <- data.table(expand.grid(owner=All.owner.dt$owner, question_id=All.question.dt$question_id, KEEP.OUT.ATTRS = FALSE))
  All.question_quiz.dt <- derivative_questions[, list(question_id=id,quiz_id), with=TRUE]
  All.owner_question_quiz.dt <- merge(All.owner_question.dt, All.question_quiz.dt, by=c('question_id'))

  # 
  owner_question_correct.dt <- derivative_answers[, list(correct=any(correct), attempts=.N), by=list(question_id,owner)]
  All.owner_question_correct.dt <- merge(All.owner_question_quiz.dt, owner_question_correct.dt, by=c("owner", "question_id"), all.y=TRUE)
  All.owner_question_correct.dt <- All.owner_question_correct.dt[order(owner, question_id)]

  # answers_with_quiz <- rbindlist(list(derivative_answers_with_quiz, tangent_answers_with_quiz), use.names=TRUE, fill=FALSE)
  
  "Pre-quiz"
  "Post-quiz"
}
