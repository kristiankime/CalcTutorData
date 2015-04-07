

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
WriteOutQuiz <- function(quizName) {
  quizId <- quizzes[ name == quizName, id]
  quizQuestions <- answers.summary[quiz_id == quizId]
  write.csv(quizQuestions, HWTableFile(quizName))
}
WriteOutQuiz("Pre-quiz")
WriteOutQuiz("Post-quiz")

games.summary <- {  
  requestor.games.dt <- games[,
                              list(
                                user_id = requestor,  
                                game_id = id,
                                quiz_done = requestor_quiz_done,
                                user_finished = requestor_finished,  
                                game_finished = !is.na(finished_date),
                                requestor = TRUE,
                                request_date = request_date,	
                                skill = requestor_skill,
                                response = response,
                                course_id = course,	
                                quiz_id = requestor_quiz,	
                                student_points = requestor_student_points,	
                                teacher_points = requestor_teacher_points,	
                                finished_date = finished_date)
                              ,with=TRUE]
  
    requestee.games.dt <- games[,
                              list(
                                user_id = requestee,
                                game_id = id,
                                quiz_done = requestee_quiz_done,  
                                game_finished = !is.na(finished_date),
                                user_finished = requestee_finished,
                                requestor = FALSE,
                                request_date = request_date,  
                                skill = requestee_skill,
                                response = response,
                                course_id = course,	
                                quiz_id = requestee_quiz,	
                                student_points = requestee_student_points,	
                                teacher_points = requestee_teacher_points,	
                                finished_date = finished_date)
                              ,with=TRUE]
  game.summary.dt <- rbindlist(list(requestor.games.dt, requestee.games.dt), use.names=TRUE, fill=FALSE)
  game.summary.dt <- merge(game.summary.dt, userInfo.dt, by=c("user_id"), all.x=TRUE)
  setcolorder(game.summary.dt, 
            c( "user_id", 
               "name", 
               "email", 
               "game_id", 
               "quiz_done", 
               "user_finished", 
               "game_finished", 
               "requestor", 
               "request_date", 
               "skill", 
               "response", 
               "course_id", 
               "quiz_id", 
               "student_points", 
               "teacher_points", 
               "finished_date"))
}

write.csv(games.summary, HWTableFile("Game-Summaries"))
