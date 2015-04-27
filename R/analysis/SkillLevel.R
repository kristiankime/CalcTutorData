
analysisDir = paste0(dataRoot, "/analysis") 

# matching to attempts/correct to difficulty
users10a <- ftable(UsersMath10AWithExams())$rename("user_id", "answerer_id")$dt
questions.dt <- ftable(questions.details.dt)$merge(users10a, by=c("answerer_id"))$filter(math10a == TRUE)$dt

foo <- ftable(questions.dt)$group(
  skill_level=sum(correct) / .N, 
  by=c("answerer_id", "email", "name", "pre_test", "exam1",  "exam2"))$order(-skill_level)$dt

 # foo <- ftable(UsersMath10AWithExams())$order(-exam1, -exam2)$dt

fit <- lm(exam2 ~ skill_level, data=foo)
plot(foo$skill_level, foo$exam1)
#text(userSkill$skill_level, userSkill$exam1, labels=userSkill$answerer_id, cex= 0.7)
abline(fit) 
#dev.off()
summary(fit)


# =============== Skill Level

top5.questions.answered <- ftable(questions.dt)$filter(
  math10a == TRUE &
  !is.na(exam1) &
  !is.na(exam2) & 
  # exam1 > 35 & 
  # exam2 > 35 &
  TRUE
  )$order(answerer_id, -question_difficulty)$dt[, head(.SD, 5), by="answerer_id"]

userSkill <- ftable(top5.questions.answered)$group(
  skill_level=mean(question_difficulty), 
  by=c("answerer_id", "email", "name", "pre_test", "exam1",	"exam2"))$filter(
    skill_level > 35 &
    skill_level < 65)$dt


#pdf(paste0(analysisDir, "/Skill Level Vs Examn Grades.pdf"),width=7,height=5)
skillLevel.vs.exam1 <- lm(exam2 ~ skill_level, data=userSkill)
plot(userSkill$skill_level, userSkill$exam1)
#text(userSkill$skill_level, userSkill$exam1, labels=userSkill$answerer_id, cex= 0.7)
abline(skillLevel.vs.exam1) 
#dev.off()
summary(skillLevel.vs.exam1)



