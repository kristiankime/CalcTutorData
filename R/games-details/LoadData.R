LoadGamesDetails <- function(){
  assign("games.details.dt", GamesDetails(), envir=.GlobalEnv)
  assign("user.math10A.dt", UsersMath10A(), envir=.GlobalEnv) 
  assign("questions.details.dt", QuestionDetails(), envir=.GlobalEnv)
  assign("game.teacher.dt", GameTeacherDetails(), envir=.GlobalEnv)
  assign("game.student.dt", GameStudentDetails(), envir=.GlobalEnv)
}

WriteGamesFiles <- function() {
  saveRDS(game.teacher.dt, file=GamesTableFileRaw("games.teacher"))
  write.csv(game.teacher.dt, file=GamesTableFileCSV("games.teacher"))
  
  saveRDS(game.student.dt, file=GamesTableFileRaw("games.student"))
  write.csv(game.student.dt, file=GamesTableFileCSV("games.student"))
}