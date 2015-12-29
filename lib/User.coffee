Meteor.users.allow
  update: (userId, user, fields, modifier) ->
    console.log(userId)
    Meteor.user().profile.level >= 3