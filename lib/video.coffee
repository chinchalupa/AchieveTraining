@Video = new Mongo.Collection('videos')

@Video.allow
  insert: (userId, post) ->
    level = Meteor.user().profile.level
    level >= 3

  remove: (userId, post) ->
    level = Meteor.user().profile.level
    level >= 3

  update: (userId, post) ->
    level = Meteor.user().profile.level
    level >= 3