module.exports = (grunt) ->

  grunt.initConfig
    nodeunit:
      files: ['test/**/*_test.js']
    # watch:
    #   gruntfile:
    #     files: '<%= jshint.gruntfile.src %>'
    #     tasks: ['jshint:gruntfile']
    #   lib:
    #     files: '<%= jshint.lib.src %>'
    #     tasks: ['jshint:lib', 'nodeunit']
    #   test:
    #     files: '<%= jshint.test.src %>'
    #     tasks: ['jshint:test', 'nodeunit']
    coffee:
      compile:
        expand: true
        src: ['app.coffee', 'bin/**/*.coffee', 'routes/**/*.coffee', 'assets/**/*.coffee']
        dest: 'build'
        ext: '.js'
    haml:
      compile:
        options:
          language: 'coffee'
          target: 'js'
          pathRelativeTo: 'assets/'
          includePath: true
        files: grunt.file.expandMapping(['assets/templates/**/*.hamlc'], 'build/hamlc/',
          rename: (base, path) -> 
            return base + path.replace(/\.hamlc$/, '.js');
        )
    execute:
      cotton:
        src: ['build/bin/www.js']
    clean:
      build:
        src: ['build']

  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-nodeunit')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-execute')
  grunt.loadNpmTasks('grunt-haml')
  grunt.loadNpmTasks('grunt-run')

  grunt.registerTask('default', ['nodeunit'])
  grunt.registerTask('compile', ['haml', 'coffee'])
  grunt.registerTask('run', ['compile', 'execute'])
