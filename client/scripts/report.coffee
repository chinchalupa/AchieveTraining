Template.report.onCreated( ->
  
  # User report
  @userStoredQuizData = new ReactiveVar([])
  
  # The name of the user being reported
  @userReportName = new ReactiveVar(@data[0].username)

#  Generate user report
  unless _.isEmpty(@data)
    quizzes = @data[0].profile.quizzes

    _.map(quizzes, (completed, quizId) ->

#       Get the quiz and video
      quiz = Quiz.findOne(_id: quizId)
      video = Video.findOne(_id: quiz.videoId)

#      Make sure both the quiz and the video exist
      unless _.isUndefined(quiz) or _.isUndefined(video)
        quizDisplayData = {}
        quizDisplayData.name = video.name
        quizDisplayData.quizLevel = quiz.level
        quizDisplayData.complete = "Incomplete"
        quizDisplayData.highlight = false

#        Change the displayed data if already completed
        if(completed)
          quizDisplayData.complete = "Complete"
          quizDisplayData.highlight = true

        tempUserData = Template.instance().userStoredQuizData.get()
        tempUserData.push(quizDisplayData)
        Template.instance().userStoredQuizData.set(tempUserData)
    )
)

Template.report.helpers(
  
#  Get the user quizzes
  userQuizzes: () ->
    Template.instance().userStoredQuizData.get()

#  Get the user's name
  userBeingReported: ->
    Template.instance().userReportName.get()
)

