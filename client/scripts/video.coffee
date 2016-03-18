Template.video.onCreated( ->
  @isComplete = new ReactiveVar(false)
)


Template.video.onRendered( ->
  $('.correct').hide()
  $('.wrong').hide()
)

Template.video.helpers(
  getName: ->
    if @[0]
      @[0].name

  getPdf: ->
    if @[0]
      @[0].pdf

  getQuizQuestions: ->
    if @[0]
      quiz = Quiz.findOne(videoId: @[0]._id)
      Question.find(quizId: quiz._id)

  getAnswers: ->
    @answers

  isCheckbox: (correctOptions) ->
    correctOptions.length > 1

  hasSrc: ->

    video = @[0]

    if video
      return video.url? && video.url != ""

  getSrc: ->
    if @[0]
      @[0].url

  getChat: ->
    if @[0]
      @[0].chatUrl

  getIsComplete: ->
    return Template.instance().isComplete.get()

  hasChat: ->
    if @[0]
      return @[0].chatUrl != "" && @[0].chatUrl != null && @[0].level is -1
    else
      false
)

Template.video.events(
  'submit form': (e, template) ->
    e.preventDefault()
    e.stopPropagation()

    names = []
    _.each $(':radio'), (groups) ->
      names.push(groups.name)

    _.each $(':checkbox'), (groups) ->
      names.push(groups.name)

    total = 0.0
    totalCorrect = 0.0


    _.each names, (item) ->

      total++
      correctAnswers = Question.findOne(_id: item).correct

      buttons
      checkedButtons = []

      if correctAnswers.length > 1
        buttons = $('form input:checkbox[name=' + item + ']')
        checkedButtons = $(buttons.filter('input:checked'))
      else
        buttons = $('form input:radio[name=' + item + ']')
        checkedButtons = $(buttons.filter('input:checked'))

      ids = _.map checkedButtons, (button) ->
        return parseInt(button.id)


      remainder = _.reject correctAnswers, (num) ->
        ids.indexOf(num) > -1

#      console.log "Answers: ", correctAnswers, "IDS: ", ids, "Remainder", remainder, "Length", remainder.length


      if remainder.length is 0
        totalCorrect += 1.0
        $('.' + item + '.correct').show()
        $('.' + item + '.wrong').hide()
      else
        $('.' + item + '.correct').hide()
        $('.' + item + '.wrong').show()




    if parseFloat(totalCorrect / total) > 0.85
      console.log("GOOD JOB")
      set = {}
      quiz = Quiz.findOne(videoId: @[0]._id)
      set['profile.quizzes.' + quiz._id] = 1
      Meteor.users.update({_id: Meteor.user()._id},
      $set: set)

      template.isComplete.set(true)




)


