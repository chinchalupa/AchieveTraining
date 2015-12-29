Template.newUserModal.events(
  'submit form': (e, template) ->

    e.preventDefault()
    e.stopPropagation()

    username = e.target[0].value
    password = e.target[1].value
    retype = e.target[2].value
    position = e.target[3].value
    level = convertPosition(position)

    $('#newUserModal').modal('hide');


    Meteor.call('createUserServerSide', username, password, level)
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