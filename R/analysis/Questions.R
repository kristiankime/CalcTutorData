# questions.details.dt <- QuestionDetails()

analysisDir = paste0(dataRoot, "/analysis") 

# matching to attempts/correct to difficulty
users10a <- ftable(UsersMath10A())$rename("user_id", "answerer_id")$dt
questions.dt <- ftable(questions.details.dt)$merge(users10a, by=c("answerer_id"))$filter(math10a == TRUE)$dt





# 
questions.summary.dt <- ftable(questions.details.dt)$group(
  difficulty=max(question_difficulty),
  num_answerers=.N,
  num_attempts=sum(attempts),
  avg_attemts=mean(attempts),
  num_correct=sum(correct),
  percent_correct=sum(correct) / .N,
  by=c("question_id"))$order(-difficulty)$dt


# Bad questions ids?
# 146
# 133
# $filter( !(question_id %in% c(146, 133)) & question_difficulty < 30 )
# $filter( !(question_id %in% c(146, 133)) )
# bad.questions <- c(133, 129) # Multiple R-squared:  0.6408,  Adjusted R-squared:  0.6237 
#questions.summary.n.dt <- ftable(questions.details.dt)$filter(type == "der")$filter(!(question_id %in% bad.questions))$group(
questions.summary.n.dt <- ftable(questions.details.dt)$filter(type == "der")$group(
  difficulty=max(question_difficulty),
  num_answerers=.N,
  num_attempts=sum(attempts),
  avg_attemts=mean(attempts),
  num_correct=sum(correct),
  percent_correct=sum(correct) / .N,
  by=c("question_id"))$order(-difficulty)$filter(num_answerers > 1)$dt

#pdf(paste0(analysisDir, "/Question Difficulty Vs Percent Correct.pdf"),width=7,height=5)
diff.vs.percentCorrect <- lm(percent_correct ~ difficulty, data=questions.summary.n.dt)
plot(questions.summary.n.dt$difficulty, questions.summary.n.dt$percent_correct)
text(questions.summary.n.dt$difficulty, questions.summary.n.dt$percent_correct, labels=questions.summary.n.dt$question_id, cex= 0.7)
abline(diff.vs.percentCorrect) 
#dev.off()
summary(diff.vs.percentCorrect)
nrow(questions.summary.n.dt)

max(questions.summary.n.dt$num_answerers)
min(questions.summary.n.dt$num_answerers)

# Multiple R-squared:  0.5496,  Adjusted R-squared:  0.5271 
question133 <- questions.dt[ question_id == 133] # Multiple R-squared:  0.6684,  Adjusted R-squared:  0.6509 
question129 <- questions.dt[ question_id == 129] # Multiple R-squared:  0.6485,  Adjusted R-squared:   0.63  







# =============== WIP below here



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

plot(questions.dt[correct == TRUE]$question_difficulty, questions.dt[correct == TRUE]$attempts)


#tmp <- data.table(foo=c(1, 2, 3), bar=c(1, 2, 3))
#fit <- lm(foo ~ bar, data=tmp)
#summary(fit)










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