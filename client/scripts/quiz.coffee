Template.quiz.helpers(

  'getName': () ->
    if @[0]
      @[0].name
    else
      ""

  getQuestions: () ->
    if @[0]
      Question.find(quizId: @[0]._id)

  getQuestionAnswers: () ->
    return @answers
)

Template.quiz.events(
  'click #createQuestion': (e, template) ->
    question = Question.insert(
      quizId: @[0]._id
    )
    Session.set('active-question', question)


  'click .edit': (e, template) ->
    Session.set('active-question', @_id)

  'click .remove': (e, template) ->
    Question.remove(_id: @_id)

)