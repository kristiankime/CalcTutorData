

gm10a <- ftable(game.teacher.dt)$filter(
  (user_math10a == TRUE) & 
  (partner_skill > 5) & 
  (game_finished == TRUE))$order(-user_teacher_points, user_id)$dt

gm10a$hardQuestion <- ((gm10a$question_difficulty / gm10a$partner_skill) >= .70)
gm10a$goodHardQuestion <- (gm10a$hardQuestion & gm10a$correct)
gm10a$easyQuestion <- ((gm10a$question_difficulty / gm10a$partner_skill) <= .30)
gm10a$goodEasyQuestion <- (gm10a$easyQuestion & (!gm10a$correct))
gm10a$goodQuestion <- (gm10a$goodHardQuestion | gm10a$goodEasyQuestion)


gm10a.goodTeacher <- ftable(gm10a)$filter(user_teacher_points >= .7)$order(user_id)$dt

gm10a.goodTeacher2 <- ftable(gm10a)$group(
  num_questions=.N, 
  num_good_hard=sum(goodHardQuestion, na.rm=TRUE),
  num_good_easy=sum(goodEasyQuestion, na.rm=TRUE), 
  percent=(sum(goodQuestion, na.rm=TRUE) / .N), 
  by="user_id")$order(-percent)$dt




fit <- glm(goodQuestion ~ partner_skill, data=gm10a, family=binomial())
summary(fit) # display results
confint(fit) # 95% CI for the coefficients
exp(coef(fit)) # exponentiated coefficients
exp(confint(fit)) # 95% CI for exponentiated coefficients
predict(fit, type="response") # predicted values
residuals(fit, type="deviance") # residuals


fit <- glm(goodQuestion ~ user_skill + partner_skill, data=gm10a, family=binomial())
summary(fit) # display results
confint(fit) # 95% CI for the coefficients
exp(coef(fit)) # exponentiated coefficients
exp(confint(fit)) # 95% CI for exponentiated coefficients
predict(fit, type="response") # predicted values
residuals(fit, type="deviance") # residuals

fit <- glm(goodQuestion ~ user_skill + partner_skill + question_difficulty, data=gm10a, family=binomial())
summary(fit) # display results
confint(fit) # 95% CI for the coefficients
exp(coef(fit)) # exponentiated coefficients
exp(confint(fit)) # 95% CI for exponentiated coefficients
predict(fit, type="response") # predicted values
residuals(fit, type="deviance") # residuals







numQuestions <- nrow(gm10a)
numGoodQuestions <- nrow(gm10a[gm10a$goodQuestion])

paste0(numGoodQuestions, " out of ", numQuestions)

analysisDir = paste0(dataRoot, "/analysis") 

pdf(paste0(analysisDir, "/Partner Skill vs Asked Question Difficulty.pdf"),width=7,height=5)
plot(gm10a$partner_skill, gm10a$question_difficulty, xlab = "Partner Skill", ylab="Question Difficulty")
dev.off()


