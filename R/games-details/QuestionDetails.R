QuestionDetails <- function() {
  derivative.answers.group <- ftable(db.derivative.answers.dt)$group(correct=any(correct), attempts=.N, by=c("owner", "question_id"))$dt
  derivative.question.group <- ftable(db.derivative.questions.dt)$select(quiz_id=quiz_id, asker_id=owner, question_id=id, question_difficulty=at_creation_difficulty, type="der", question=rawstr)$dt 
  derivatives.qa <- ftable(derivative.question.group)$leftJoin(derivative.answers.group, on=c("question_id"))$select(question_id, asker_id=asker_id, answerer_id=owner, quiz_id, question_difficulty, type, question, correct, attempts)$dt

  tangent.answers.group <- ftable(db.tangent.answers.dt)$group(correct=any(correct), attempts=.N, by=c("owner", "question_id"))$dt
  tangent.question.group <- ftable(db.tangent.questions.dt)$select(quiz_id=quiz_id, asker_id=owner, question_id=id, question_difficulty=at_creation_difficulty, type="der", question=paste0(function_str, " @ ", at_point_x_str))$dt 
  tangents.qa <- ftable(tangent.question.group)$leftJoin(tangent.answers.group, on=c("question_id"))$select(question_id, asker_id=asker_id, answerer_id=owner, quiz_id, question_difficulty, type, question, correct, attempts)$dt
  
  questions.details <- ftable(derivatives.qa)$union(tangents.qa)$order(question_id)$dt
}