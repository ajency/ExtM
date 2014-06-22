# Generated by CoffeeScript 1.7.1
path = undefined
path = require( "path" )
module.exports = ( grunt ) ->
   require( "matchdep" ).filterDev( "grunt-*" ).forEach grunt.loadNpmTasks
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

      

   grunt.registerTask "verify-bower", ->
      grunt.fail.warn "Missing bower components. You should run `bower install` before."  unless grunt.file.isDir( "./bower_components" )

