@Quiz = new Mongo.Collection('quizzes')

@Quiz.allow(
  insert: (userId, quiz) ->
    return  Meteor.user().profile.level >= 3
  remove: (userId, quiz) ->
    return  Meteor.user().profile.level >= 3
)

Meteor.methods(
  'createQuiz': (quizId, level, videoId) ->
    console.log quizId + " " + level + " " + videoId
    Quiz.update(
      {"_id": quizId},
      {$set: {"level": level}}
    )

    set = {}
    set['profile.quizzes.' + quizId] = 0

    Meteor.users.update('profile.level': {$gte: level},
      {$set: set},
      {multi: true})

  'destroyQuiz': (quizId) ->
    set = {}
    set['profile.quizzes.' + quizId] = ""

    Meteor.users.update('profile.level': {$gte: 0},
      {$unset: set},
      {multi: true})
)