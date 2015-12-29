Template.appLayout.helpers(
  isAdmin: ->
    if Meteor.user()
      Meteor.user().profile.level >= 3
    else
      false
)

Template.appLayout.events(
  'click #signOutButton': (e, template) ->
    Router.go('/')
    Meteor.logout()

  'click #videoLink': (e, template) ->
    Router.go('/home')
)