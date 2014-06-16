# load all the scripts required for SPA
requirejs.config
    urlArgs : "?ver=#{Math.random()}"
    baseUrl : '../'
    paths :
        jquery : 'bower_components/jquery/dist/jquery'
        backbone : 'bower_components/backbone/backbone'
        underscore : 'bower_components/underscore/underscore'
        marionette : 'bower_components/marionette/lib/core/amd/backbone.marionette'
        mustache : 'bower_components/mustache/mustache'
        text : 'bower_components/requirejs-text/text'
        backbonesyphon : 'bower_components/backbone.syphon/lib/amd/backbone.syphon'
        'backbone.wreqr' : 'bower_components/backbone.wreqr/lib/backbone.wreqr'
        'backbone.babysitter' : 'bower_components/backbone.babysitter/lib/backbone.babysitter'
        plupload : 'bower_components/plupload/js/plupload.full.min'
        jqueryvalidate : 'bower_components/jquery.validation/dist/jquery.validate'
    shim :
        jquery : [ 'underscore' ]
        backbone : [ 'jquery', 'underscore' ]
        marionette :
            deps : [ 'backbone', 'backbone.wreqr', 'backbone.babysitter' ]
        backbonesyphon : [ 'backbone' ]
        jqueryvalidate : [ 'jquery' ]
        bootstrap : [ 'jquery' ]
        plupload :
            deps : [ 'jquery' ]
            exports : 'plupload'