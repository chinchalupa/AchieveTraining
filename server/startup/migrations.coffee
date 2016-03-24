Migrations.add(
  "version": 1,
  "name": "Add levels to the quizzes themselves.",
  "up": ->
    allQuizzes = Quiz.find().fetch()
    _.each(allQuizzes, (quiz) ->
      video = Video.findOne(_id: quiz.videoId)
      videoLevel = video.level
      console.log(videoLevel)
      Quiz.update(
        {},
        $set: {"level": videoLevel}
      )
    )

  "down": ->

)