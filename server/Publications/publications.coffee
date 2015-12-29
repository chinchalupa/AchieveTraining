Meteor.publish 'userReport', (id) ->
  Meteor.users.find(_id: id)

Meteor.publish 'allUsers', ->
  Meteor.users.find()

Meteor.publish 'allVideos', ->
  Video.find()

Meteor.publish 'allQuizzes', ->
  Quiz.find()

Meteor.publish 'videoQuiz', (videoId) ->
  Quiz.find(videoId: videoId)

Meteor.publish 'video', (videoId) ->
  Video.find(_id: videoId)

Meteor.publish 'videosAtLevel', (userLevel) ->
  Video.find(level: {$lte: userLevel})

Meteor.publish 'quiz', (quizId) ->
  Quiz.find(_id: quizId)

Meteor.publish 'quizzesAtLevel', (userLevel) ->
  Quiz.find(level: {$lte: userLevel})

Meteor.publish 'findQuestionsFromVideo', (videoId) ->
  quiz = Quiz.findOne(videoId: videoId)
  quizId = quiz._id
  Question.find(quizId: quizId)
