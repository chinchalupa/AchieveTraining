path = Npm.require 'path'
fs = Npm.require 'fs'
dir = path.resolve "..\\..\\..\\..\\..\\pdfs"

Meteor.methods(
  writePDF: (pdf, pdfName) ->

    fs.writeFileSync(dir + '\\' + pdfName, pdf, 'binary')


  readPDF: (pdfName) ->

    fs.readFileSync(dir + '\\' + pdfName)
)