@Question = new Mongo.Collection('questions')

@Question.allow(
  insert: (userId, question) ->
    Meteor.user().profile.level >= 3

  remove: (userId, question) ->
    Meteor.user().profile.level >= 3

  update: (userId, question) ->
    Meteor.user().profile.level >= 3
)