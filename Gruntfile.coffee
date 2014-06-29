# Generated by CoffeeScript 1.7.1
path = require( "path" )
module.exports = ( grunt ) ->

   grunt.initConfig
      pkg : grunt.file.readJSON( "package.json" )
      meta :
         version : "<%= pkg.version %>"
         core_banner : "// ExtM (Extende Marionette)\n"
         banner : "<%= meta.core_banner %>\n" + "/*!\n"

      clean :
         lib : "lib"
         tmp : "tmp"

      plato :
         extm :
            src : "src/**/*.js"
            dest : "reports"
            options :
               jshint : grunt.file.readJSON( ".jshintrc" )

      docker :
         extm :
            src : [ "src/**/*.coffee" ]
            dest : "docs"

      jshint :
         options :
            jshintrc : ".jshintrc"

         marionette : [ "src/**/*.js" ]

      lintspaces :
         all :
            src : [
               "src/**/*.coffee"
               "src/**/*.js"
               "docs/*.md"
            ]
            options :
               editorconfig : ".editorconfig"

      preprocess :
         core_build :
            src : 'src/build/extm.core.js'
            dest : 'lib/extm.core.js'
         test_file :
            src : 'src/build/extm.core.js'
            dest : 'tmp/extm.core.js'
         amd :
            src : 'src/build/extm.amd.js'
            dest : 'lib/extm.amd.js'

   require( "matchdep" ).filterDev( "grunt-*" ).forEach grunt.loadNpmTasks

   grunt.registerTask "verify-bower", ->
      grunt.fail.warn "Missing bower components. You should run `bower install` before."  unless grunt.file.isDir( "./bower_components" )

