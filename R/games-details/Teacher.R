
GamesTableFile <- function(table) { paste0(dataRoot, "/games-details/", table,".csv") }
HWTableFile <- function(table) { paste0(dataRoot, "/math10a/", table,".csv") }

games.details <- {  
  requestor.games.dt <- games[,
                              list(
                                user_id = requestor,  
                                game_id = id,
                                quiz_done = requestor_quiz_done,
                                user_finished = requestor_finished,  
                                game_finished = !is.na(finished_date),
                                requestor = TRUE,
                                request_date = request_date,	
                                user_skill = requestor_skill,
                                partner_skill = requestee_skill,
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
                                user_skill = requestee_skill,
                                partner_skill = requestor_skill,
                                response = response,
                                course_id = course,	
                                quiz_id = requestee_quiz,	
                                student_points = requestee_student_points,	
                                teacher_points = requestee_teacher_points,	
                                finished_date = finished_date)
                              ,with=TRUE]
  game.summary.dt <- rbindlist(list(requestor.games.dt, requestee.games.dt), use.names=TRUE, fill=FALSE)
  
  
  userInfo.dt <- secure_social_logins[,list(user_id=id, name=full_name, email=email),with=TRUE]
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
               "user_skill",
               "partner_skill",
               "response", 
               "course_id", 
               "quiz_id", 
               "student_points", 
               "teacher_points", 
               "finished_date"))
  
  
}

# write.csv(games.summary, GamesTableFile("Game-Details"))
