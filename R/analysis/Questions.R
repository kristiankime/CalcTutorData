# questions.details.dt <- QuestionDetails()

analysisDir = paste0(dataRoot, "/analysis") 

# matching to attempts/correct to difficulty
users10a <- ftable(UsersMath10A())$rename("user_id", "answerer_id")$dt
questions.dt <- ftable(questions.details.dt)$merge(users10a, by=c("answerer_id"))$filter(math10a == TRUE)$dt

# adding correct int lm
fit <- lm(question_difficulty ~ attempts + correct, data=questions.dt)
summary(fit)
# splitting data by correct 
# --- predicting difficulty
fit <- lm(question_difficulty ~ attempts, data=questions.dt[correct == TRUE])
summary(fit)
fit <- lm(question_difficulty ~ attempts, data=questions.dt[correct == FALSE])
summary(fit) # Note negative
# predicting attempts
fit <- lm(attempts ~ question_difficulty, data=questions.dt[correct == TRUE])
summary(fit)
fit <- lm(attempts ~ question_difficulty, data=questions.dt[correct == FALSE])
summary(fit) # Note negative




# =============== WIP below here




# 
questions.summary.dt <- ftable(questions.details.dt)$group(
  difficulty=max(question_difficulty),
  num_answerers=.N,
  num_attempts=sum(attempts),
  avg_attemts=mean(attempts),
  by=c("question_id", "correct"))$order(-num_answerers)$dt

rg <- function(v){ if(v){"green"} else {"red"} }
questions.summary.dt[, correct_color := sapply(correct, rg)]

pdf(paste0(analysisDir, "/Question Difficulty Vs Avg Attempts.pdf"),width=7,height=5)
plot(questions.summary.dt$difficulty, questions.summary.dt$avg_attemts, col=questions.summary.dt$correct_color)
dev.off()






fit <- lm(avg_attemts ~ difficulty + correct, data=questions.quiz.dt)
summary(fit)
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(fit)

layout(matrix(c(1),1,1)) # reset layout

par(mfrow=c(1,1))