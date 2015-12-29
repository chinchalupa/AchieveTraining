Template.newVideoModal.events(
  'submit form': (e, template) ->

    e.preventDefault()

    url = e.target[0].value
    name = e.target[1].value
    position = e.target[2].value
    pdf = e.target[3].files[0]
    pdfName = ""
    if pdf
      pdfName = pdf.name

    freader = new FileReader()

    freader.onloadend = ->
      Meteor.call('writePDF', freader.result, pdfName)

      videoId = Video.insert(
        url: url,
        name: name,
        level: level,
        pdf: pdfName
      )

      quiz = Quiz.insert(
        videoId: videoId,
        level: level,
        name: name
      )

      Meteor.call('createQuiz', quiz, level)

    level = convertPosition(position)

    if !_.isUndefined(pdf)
      freader.readAsBinaryString(pdf)

    else
      videoId = Video.insert(
        url: url,
        name: name,
        level: level
      )

      quiz = Quiz.insert(
        videoId: videoId,
        level: level,
        name: name
      )

      Meteor.call('createQuiz', quiz, level)

    $('#newVideoModal').modal('hide');

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
    return 0


