

gm10a <- game.teacher.dt[ (user_math10a == TRUE) & (partner_skill > 5) & (game_finished == TRUE)]
gm10a$hardQuestion <- ((gm10a$question_difficulty / gm10a$partner_skill) >= .75)
gm10a$goodHardQuestion <- (gm10a$hardQuestion & gm10a$correct)
gm10a$easyQuestion <- ((gm10a$question_difficulty / gm10a$partner_skill) <= .25)
gm10a$goodEasyQuestion <- (gm10a$easyQuestion & (!gm10a$correct))
gm10a$goodQuestion <- (gm10a$goodHardQuestion | gm10a$goodEasyQuestion)

numQuestions <- nrow(gm10a)
numGoodQuestions <- nrow(gm10a[gm10a$goodQuestion])

paste0(numGoodQuestions, " out of ", numQuestions)

analysisDir = paste0(dataRoot, "/analysis") 

pdf(paste0(analysisDir, "/Partner Skill vs Asked Question Difficulty.pdf"),width=7,height=5)
plot(gm10a$partner_skill, gm10a$question_difficulty, xlab = "Partner Skill", ylab="Question Difficulty")
dev.off()

