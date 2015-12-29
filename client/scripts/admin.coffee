Template.admin.helpers(
  allUsers: () ->
    Meteor.users.find()

  allVideos: () ->
    Video.find()

  quizExists: (id) ->
    Quiz.find(videoId: id).fetch().length > 0
)

Template.admin.events(

  'click .remove-video': (e, template) ->
    Video.remove(_id: @_id)
    quiz = Quiz.findOne(videoId: @_id)
    Quiz.remove(_id: quiz._id)

    Meteor.call('destroyQuiz', quiz._id)


  'change .user-level': (e, template) ->
    position = e.target.value
    level = convertPosition(position)

    Meteor.users.update({_id: @_id}
    $set: {'profile.level': level})

  'change .video-level': (e, template) ->
    position = e.target.value
    level = convertPosition(position)

    Video.update({_id: @_id}
    $set: {'level': level})

    video = Video.findOne(_id: @_id)

    quiz = Quiz.findOne(videoId: video._id)

    Meteor.call('updateQuizLevel', quiz, level)
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

