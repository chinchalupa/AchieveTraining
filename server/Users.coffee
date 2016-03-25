Accounts.onCreateUser (options, user) ->
#  newUser = user
  userLevel = options.profile.level

  quizzes = Quiz.find(level: {$lte: userLevel}).fetch()

  obj = {}

  _.each quizzes, (item) ->
    obj[item._id] = 0

  options.profile['quizzes'] = obj

  if options.profile
    user['profile'] = options.profile
  return user

Meteor.methods(
  

#
  updateUserLevel: (userId, level) ->
    user = Meteor.users.findOne(_id: userId)
    userQuizzes = user.profile.quizzes

    remainingQuizzes = {}
    _.each userQuizzes, (completed, id) ->

      quiz = Quiz.findOne(_id: id)

      if quiz.level <= level
        remainingQuizzes['quiz._id'] = userQuizzes['quiz._id']

  createUserServerSide: (username, password, level) ->
    Accounts.createUser(
      username: username,
      password: password,
      profile:
        level: level
    )

)