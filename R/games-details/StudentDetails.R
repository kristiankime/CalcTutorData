GameStudentDetails <- function() {
  user.main <- ftable(user.math10A.dt)$select(user_id=user_id, user_name=name, user_math10a=math10a)$dt
  user.partner <- ftable(user.math10A.dt)$select(partner_id=user_id, partner_name=name, partner_math10a=math10a)$dt
  game.math10a.dt <- ftable(games.details.dt)$merge(user.main, by=("user_id"))$merge(user.partner, by=("partner_id"))$dt
  
  questions.user <- ftable(questions.details.dt)$select(
    user_quiz_id=quiz_id, user_id=answerer_id, partner_id=asker_id, question_id, question_difficulty, type, correct, attempts
    )$filter(!is.na(user_quiz_id))$dt

  game.student.questions <- ftable(game.math10a.dt)$leftJoin(questions.user, on=c("user_quiz_id", "user_id", "partner_id"))$filter(!is.na(game_id))$dt
 
  ftable(game.student.questions)$select(
    game_id,
    user_id, user_name, user_math10a,
    partner_id, partner_name, partner_math10a,
    course_id,
    user_skill,
    partner_skill,
    user_student_points,
    user_teacher_points,
    partner_student_points,
    partner_teacher_points,
    question_id, question_difficulty, type, correct, attempts,
    requestor, request_date, response,
    user_quiz_id, user_quiz_done, partner_quiz_id, partner_quiz_done, user_finished, partner_finished, game_finished, finished_date
  )$dt
}
