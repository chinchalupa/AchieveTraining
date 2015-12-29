Template.login.onCreated( ->
  @loginError = new ReactiveVar(false)
)

Template.login.helpers(
  successfulLogin: ->
    !Template.instance().loginError.get()

)

Template.login.events(
  'submit form': (e, template) ->
    username = e.target[0].value
    password = e.target[1].value

    e.preventDefault()

    Meteor.loginWithPassword(username, password, (err) ->
      if not err
        console.log(err)
        Router.go('/home')
      else
        template.loginError.set(true)
    )
)

#Template.login.onCreated(->
#  Accounts.createUser
#    username: 'levels3',
#    password: "password",
#    profile:
#      level: 3
#)