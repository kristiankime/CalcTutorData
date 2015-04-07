

userInfo.dt <- secure_social_logins[,list(user_id=id, name=full_name, email=email),with=TRUE]

answers.summary <- {  
  ownerQuestionCorrect <- function(question.dt, answer.dt) {
    userId_questionId_info.dt <- answer.dt[, list(correct=any(correct), attempts=.N), by=list(question_id,user_id=owner)]
    questionId_quizId.dt <- question.dt[, list(question_id=id,quiz_id), with=TRUE]
    userId_questionId_quiz_id_info.dt <- merge(userId_questionId_info.dt, questionId_quizId.dt, by=c("question_id"), all.x=TRUE)
  }
  
  derivative.owner_question_correct.dt <- ownerQuestionCorrect(derivative_questions, derivative_answers)
  tangent.owner_question_correct.dt <- ownerQuestionCorrect(derivative_questions, derivative_answers)
  
  owner_question_correct.dt <- rbindlist(list(derivative.owner_question_correct.dt, tangent.owner_question_correct.dt), use.names=TRUE, fill=FALSE)
  owner_question_correct.dt <- merge(owner_question_correct.dt, userInfo.dt, by=c("user_id"), all.x=TRUE)
  owner_question_correct.dt <- owner_question_correct.dt[order(user_id, quiz_id)]
  owner_question_correct.dt
}

HWTableFile <- function(table) { paste0(dataRoot, "/math10a/", table,".csv") }

preQuizId <- quizzes[ name == "Pre-quiz", id]
preQuizQuestions <- answers.summary[quiz_id == preQuizId]
write.csv(preQuizQuestions, HWTableFile("pre-quiz"))

postQuizId <- quizzes[ name == "Post-quiz", id]
postQuizQuestions <- answers.summary[quiz_id == preQuizId]
write.csv(preQuizQuestions, HWTableFile("post-quiz"))

