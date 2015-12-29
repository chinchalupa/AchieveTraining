Template.home.helpers(
  getVideos: ->
    userLevel = Meteor.user().profile.level
    Video.find()

  getVideosAtLevel: (videoLevel) ->
    userLevel = Meteor.user().profile.level
    Video.find( $and: [{level:  {$lte: userLevel}}, {level: { $in: [videoLevel]}}])

  getLevels: ->
    return [0, 1, 2]

  canViewLevel: (levelAbove) ->
    level = levelAbove - 1
    userLevel = 0
    if Meteor.user()
      userLevel = Meteor.user().profile.level
    else
      return false

    if userLevel is 3
      return true
    else if userLevel <= level
      return false
    else

      quizzes = Quiz.find(level: level).fetch()

      unfinished = _.find quizzes, (quiz) ->

        Meteor.user().profile.quizzes[quiz._id] == 0

      if _.isUndefined(unfinished)
        return true
    return false


  completed: (id) ->
    quiz = Quiz.findOne(videoId: id)
    if quiz
      Meteor.user().profile.quizzes[quiz._id]
)



