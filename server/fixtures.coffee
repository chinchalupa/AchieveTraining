if Meteor.users.find().count() is 0
  Accounts.createUser(
    username: "admin",
    email: "jim@myachieveweightloss.com",
    password: "2015!35Pounds!",
    profile: {
      level: 3,
      quizzes: {}
    }
  )