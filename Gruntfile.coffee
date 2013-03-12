module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      app:
        expand: true
        ext: '.js'
        src: [
          'assets/js/app/*.coffee'
          'assets/js/app/**/*.coffee'
        ]

    coffeelint:
      files:
        src: ['<%= coffee.app.src %>']
      options:
        max_line_length:
          value: 120,
          level: 'warn',
          message: 'Line exceeds maximum allowed length'

    compass:
      app:
        options:
          sassDir: 'assets/css/'
          cssDir: '<%= compass.app.options.sassDir %>'
          imagesDir: 'assets/img/'

    mochaTest:
      files: ['test/**/*-test.coffee']

    mochaTestConfig:
      options:
        compilers: 'coffee:coffee-script'
        reporter: 'spec'

    watch:
      coffee:
        files: ['<%= coffee.app.src %>']
        tasks: [
          'coffeelint'
          'coffee'
        ]
      compass:
        files: ['<%= compass.app.options.sassDir %>*.scss']
        tasks: ['compass']

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.registerTask 'default', 'test our shizz', () ->
    grunt.task.run [
      'compass'
      'coffeelint'
      'coffee'
      'mochaTest'
    ]
