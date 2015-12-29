Handlebars.registerHelper 'selected', (setting, option) ->
  setting is option ? 'selected' : ''

Handlebars.registerHelper 'convertLevel', (level) ->
  if level is 0
    return "Mentor"
  else if level is 1
    return "Facilitator"
  else if level is 2
    return "Coach"
  else if level is 3
    return "Admin"