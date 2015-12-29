Template.userpage.helpers(
  canViewLevel: (levelAbove) ->
    level = levelAbove - 1
    userLevel = Meteor.user().profile.level
    console.log("LEVELS: ", level, userLevel)
    if userLevel <= level
      console.log("USER LEVEL ISSUE")
      return false
    else

      quizzes = Quiz.find(level: level).fetch()

      unfinished = _.find quizzes, (quiz) ->

        Meteor.user().profile.quizzes[quiz._id] == 0

      console.log(unfinished, level)

      if _.isUndefined(unfinished)
        return true
    return false
)