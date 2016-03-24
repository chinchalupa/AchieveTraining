Router.configure {
  layoutTemplate: 'appLayout'
}


Router.route '/', {
  name: 'login',
  template: 'login'
}

Router.route '/home', {
  name: 'home',
  template: 'home',
  onBeforeAction: () ->
    if not Meteor.userId()
      Router.go('/')
    else
      Router.go('/home')
    @next()
  waitOn: ->
    if Meteor.user()
      [Meteor.subscribe('videosAtLevel', Meteor.user().profile.level),
      Meteor.subscribe('quizzesAtLevel', Meteor.user().profile.level)]
}

Router.route '/admin', {
  name: 'admin',
  template: 'admin'
  onBeforeAction: () ->
    if Meteor.user() and Meteor.user().profile.level is 3
      @next()
    else
      Router.go('/')
  waitOn: ->
    Session.set('edited-video', null)
    [Meteor.subscribe('allVideos'), Meteor.subscribe('allUsers'), Meteor.subscribe('allQuizzes')]
}

Router.route '/video/:_id', {
  name: 'video',
  template: 'video',
  onBeforeAction: ->
    video = Video.findOne(_id: @params._id)
    if video.level < 0
      this.next()
    else
      if Meteor.user()
        this.next()
      else
        this.render 'login'
  data: () ->
    Video.find(_id: @params._id).fetch()
  waitOn: ->
    [Meteor.subscribe('video', @params._id), Meteor.subscribe('videoQuiz', @params._id), Meteor.subscribe('findQuestionsFromVideo', @params._id)]
}

Router.route 'quiz/:_id', {
  name: 'quiz',
  template: 'quiz',
  data: () ->
    Quiz.find(videoId: @params._id).fetch()
  waitOn: ->
    [Meteor.subscribe('videoQuiz', @params._id), Meteor.subscribe('findQuestionsFromVideo', @params._id)]
}

Router.route 'report/:_id', {
  name: 'report',
  template: 'report',
  data: () ->
    Meteor.users.find(_id: @params._id).fetch()

  waitOn: () ->
    Meteor.subscribe('userReport', @params_id)
}

Router.route 'user/:_id', {
  name: 'userpage',
  template: 'userpage'
}

