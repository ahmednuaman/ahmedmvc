module.exports = (grunt) ->
  # This task builds our docs
  grunt.registerTask 'docs', 'build our docs', () ->
    done = @async()

    docco = require 'doccoh'
    path = require 'path'

    src = grunt.config.get('doccoh').src
    files = grunt.file.expand src

    grunt.util._.each files, (file) ->
      dir = path.dirname(file) + '/'
      docco.document [file],
        output: 'docs/' + dir