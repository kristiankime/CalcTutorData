questions.details.dt <- {
  ftable(derivative_questions)$select(quiz_id=quiz_id, question_id=id, question_difficulty=at_creation_difficulty, type="der")$union(
     ftable(tangent_questions)$select(quiz_id=quiz_id, question_id=id, question_difficulty=at_creation_difficulty, type="tan")$dt
  )$dt
}