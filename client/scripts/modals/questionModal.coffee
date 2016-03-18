Template.questionModal.onCreated( ->
  @listOfAnswers = new ReactiveVar([])
  @listOfCorrect = new ReactiveVar([])
)

Template.questionModal.events(
  'submit form': (e, template) ->

    e.preventDefault()
    e.stopPropagation()

    answers = template.listOfAnswers.get()
    correct = template.listOfCorrect.get()

    active = Session.get('active-question')
    question = $('#question').val()

    Question.update({_id: active},
      $set: {answers: answers, question: question, correct: correct})

    $('#questionModal').modal 'hide'


  'click #addAnswer': (e, template) ->
    array = template.listOfAnswers.get()
    array.push ""
    template.listOfAnswers.set array


  'change .answer': (e, template) ->
    id = parseInt(e.target.id)

    array = template.listOfAnswers.get()

    array[id] = e.target.value
    template.listOfAnswers.set(array)

  'click .setCorrect': (e, template) ->
    id = parseInt(e.currentTarget.id)

    array = template.listOfCorrect.get()
    index = array.indexOf(id)
    if index > -1
      array.splice(index, 1)
    else
      array.push(id)
    template.listOfCorrect.set(array)

  'click .removeAnswer': (e, template) ->
    console.log @
    id = parseInt e.currentTarget.id
    console.log id

    listOfValues = template.listOfAnswers.get()
    listOfCorrectValues = template.listOfCorrect.get()

    if _.contains(listOfCorrectValues, id)

      index = listOfCorrectValues.indexOf(id)


      listOfCorrectValues.splice(index, 1)

      template.listOfCorrect.set(listOfCorrectValues)

    listOfValues.splice(id, 1)

    template.listOfAnswers.set(listOfValues)


  'shown.bs.modal #questionModal': (e, template) ->

    activeId = Session.get('active-question')

    question = Question.findOne(_id: activeId)
    if question.question
      $('#question').val(question.question)
    else
      $('#question').val("")

    if !_.isUndefined(question.answers)
      template.listOfAnswers.set(question.answers)
      template.listOfCorrect.set(question.correct)
    else
      template.listOfAnswers.set([])
      template.listOfCorrect.set([])

)

Template.questionModal.helpers(
  getAnswers: ->
    Template.instance().listOfAnswers.get()

  isCorrect: (num) ->
    if(Template.instance().listOfCorrect.get() && Template.instance().listOfCorrect.get().length > 0)
      Template.instance().listOfCorrect.get().indexOf(num) > -1
)