Template.report.helpers(
  userQuizzes: () ->
    console.log(@)
    storedQuizzes = []
    _.each @[0].profile.quizzes, (completed, quizId) ->
      quiz = Quiz.findOne(_id: quizId)
      if not _.isUndefined(quiz)
        toShow = {}
        name = quiz.name
        toShow.name = name
        toShow.complete = "Incomplete"
        toShow.highlight = false
        toShow.quizLevel = quiz.level
        if completed is 1
          toShow.complete = "Complete"
          toShow.highlight = true
        storedQuizzes.push(toShow)
    storedQuizzes

)

