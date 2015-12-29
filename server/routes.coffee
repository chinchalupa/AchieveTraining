fs = Npm.require('fs')

Router.route '/pdfs/:name', ->

  path = Npm.require 'path'
  dir = path.resolve '..\\..\\..\\..\\..\\pdfs'
  name = this.params.name
  filepath = dir + '\\' + name
  data = fs.readFileSync filepath

  this.response.write data
  this.response.end()
,
  where: 'server'
