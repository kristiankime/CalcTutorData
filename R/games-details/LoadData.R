LoadGamesDetails <- function(){
  assign("games.details.dt", GamesDetails(), envir=.GlobalEnv)
  assign("user.math10A.dt", UsersMath10A(), envir=.GlobalEnv) 
  assign("questions.details.dt", QuestionDetails(), envir=.GlobalEnv)
  assign("game.teacher.dt", GameTeacherDetails(), envir=.GlobalEnv)
}

WriteTeacherFiles <- function() {
  saveRDS(game.teacher.dt, file=GamesTableFileRaw("games.teacher"))
  write.csv(game.teacher.dt, file=GamesTableFileCSV("games.teacher"))
}