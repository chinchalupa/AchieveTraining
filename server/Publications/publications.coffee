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
  console.log "user level " + userLevel
  Quiz.find(level: {$lte: userLevel})

Meteor.publish 'findQuestionsFromVideo', (uniqueVideoId) ->
  console.log "Video ID " + uniqueVideoId
  quiz = Quiz.findOne("videoId": uniqueVideoId)
  console.log quiz
  Question.find("quizId": quiz._id)
