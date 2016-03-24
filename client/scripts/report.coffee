Template.report.onCreated( ->
  @userStoredQuizData = new ReactiveVar([])
  @userReportName = new ReactiveVar(@data[0].username)

  unless _.isEmpty(@data)
    quizzes = @data[0].profile.quizzes

    _.map(quizzes, (completed, quizId) ->

      quiz = Quiz.findOne(_id: quizId)
      video = Video.findOne(_id: quiz.videoId)

      unless _.isUndefined(quiz) or _.isUndefined(video)
        quizDisplayData = {}
        quizDisplayData.name = video.name
        quizDisplayData.quizLevel = quiz.level
        quizDisplayData.complete = "Incomplete"
        quizDisplayData.highlight = false

        if(completed)
          quizDisplayData.complete = "Complete"
          quizDisplayData.highlight = true

        tempUserData = Template.instance().userStoredQuizData.get()
        tempUserData.push(quizDisplayData)
        Template.instance().userStoredQuizData.set(tempUserData)
    )
)

Template.report.helpers(
  userQuizzes: () ->
    Template.instance().userStoredQuizData.get()

  userBeingReported: ->
    Template.instance().userReportName.get()
)

