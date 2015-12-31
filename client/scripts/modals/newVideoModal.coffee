Template.newVideoModal.onCreated( ->
  @hasChat = new ReactiveVar(false)
)

Template.newVideoModal.events(
  'submit form': (e, template) ->

    e.preventDefault()

    video = Video.findOne(_id: @_id)
    videoId = video._id

    quiz = Quiz.findOne(videoId: videoId)
    quizId = quiz._id

    url = e.target[0].value
    name = e.target[1].value
    position = e.target[2].value
    pdf = e.target[3].files[0]
    chatUrl = e.target[4].value

    level = convertPosition(position)

    pdfName = ""

    if pdf
      pdfName = pdf.name

    newVideoInformation = {
      url: url,
      name: name,
      level: level,
      pdf: pdfName,
      chatUrl: chatUrl
    }


    freader = new FileReader()

    freader.onloadend = ->
      Meteor.call('writePDF', freader.result, pdfName)

    if !_.isUndefined(pdf)
      freader.readAsBinaryString(pdf)

    Video.update(
      {_id: @_id},
      {$set: newVideoInformation}
    )

    Meteor.call('createQuiz', quizId, level)

    $('#newVideoModal').modal('hide');

  'change #videoLevel': (e, template) ->
    text = $(e.target).find("option:selected").text();
    template.hasChat.set text is "Live Class"
)

Template.newVideoModal.helpers(
  editedForm: ->
    id = Session.get('edited-video')
    Video.findOne(_id: id)

  hasChat: ->
    return Template.instance().hasChat.get() || @level is -1
)

convertPosition = (position) ->
  if position is "Mentor"
    return 0
  else if position is "Facilitator"
    return 1
  else if position is "Coach"
    return 2
  else if position is "Admin"
    return 3
  else
    return -1


