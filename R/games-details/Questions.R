questions.details.dt <- {
  derivative.answers.group <- ftable(derivative_answers)$group(correct=any(correct), attempts=.N, by=c("owner", "question_id"))$dt
  derivative.question.group <- ftable(derivative_questions)$select(quiz_id=quiz_id, asker_id=owner, question_id=id, question_difficulty=at_creation_difficulty, type="der")$dt 
  derivatives.qa <- ftable(derivative.question.group)$leftJoin(derivative.answers.group, on=c("question_id"))$select(question_id, asker_id=asker_id, answerer_id=owner, quiz_id, question_difficulty, type, correct, attempts)$dt

  tangent.answers.group <- ftable(tangent_answers)$group(correct=any(correct), attempts=.N, by=c("owner", "question_id"))$dt
  tangent.question.group <- ftable(tangent_questions)$select(quiz_id=quiz_id, asker_id=owner, question_id=id, question_difficulty=at_creation_difficulty, type="der")$dt 
  tangents.qa <- ftable(tangent.question.group)$leftJoin(tangent.answers.group, on=c("question_id"))$select(question_id, asker_id=asker_id, answerer_id=owner, quiz_id, question_difficulty, type, correct, attempts)$dt
  
  questions.details <- ftable(derivatives.qa)$union(tangents.qa)$dt
}