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

  'click .edit-video': (e, template) ->
    Session.set('edited-video', @_id)

  'click #uploadVideo': (e, template) ->

    videoId = Video.insert({})

    Quiz.insert(
      videoId: videoId
    )

    Session.set('edited-video', videoId)


  'change .user-level': (e, template) ->
    position = e.target.value
    level = convertPosition(position)

    Meteor.users.update({_id: @_id}
      $set: {'profile.level': level})

  'change .video-level': (e, template) ->
    position = e.target.value
    level = convertPosition(position)

    console.log("Calling update", @_id)

    unless (_.isNull(@))
      Meteor.call('updateVideoAndQuizLevelFromVideo', @_id, level)
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

