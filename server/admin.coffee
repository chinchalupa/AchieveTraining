Meteor.methods(
  updateVideoAndQuizLevelFromVideo: (videoId, level) ->

    Quiz.update({videoId: videoId},
      {$set: {"level": level}},
      {multi: true}
    )

    Video.update({_id: videoId},
      {$set: {"level": level}}
    )



)