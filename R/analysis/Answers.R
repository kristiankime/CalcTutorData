
analysisDir = paste0(dataRoot, "/analysis") 

users10a <- ftable(UsersMath10A())$rename("user_id", "answerer_id")$dt
derivative.answers <- ftable(db.derivative.answers.dt)$select(id=id, answerer_id=owner, question_id=question_id, answer=rawstr, answer_len=nchar(rawstr), correct=correct)$dt
derivative.question <- ftable(db.derivative.questions.dt)$select(quiz_id=quiz_id, asker_id=owner, question_id=id, question_difficulty=at_creation_difficulty, type="der", question=rawstr)$dt 
derivatives.qa <- ftable(derivative.question)$merge(derivative.answers, by="question_id")$merge(users10a, by="answerer_id")$dt

saveRDS(derivatives.qa, file=paste0(analysisDir, "/answers_with_length.rds"))
write.csv(derivatives.qa, file=paste0(analysisDir, "/answers_with_length.csv"))



derivatives.math10a.games.qa <- ftable(derivatives.qa)$filter(math10a == TRUE & !(quiz_id %in% c(1, 41, 42)))$dt



# $select(question_id, asker_id=asker_id, answerer_id=owner, quiz_id, question_difficulty, type, question, correct, attempts)$dt


d[, head(.SD, 3), by=cyl]