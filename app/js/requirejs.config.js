// Generated by CoffeeScript 1.7.1
requirejs.config({
  urlArgs: "?ver=" + (Math.random()),
  baseUrl: '../',
  paths: {
    jquery: 'bower_components/jquery/dist/jquery',
    backbone: 'bower_components/backbone/backbone',
    underscore: 'bower_components/underscore/underscore',
    marionette: 'bower_components/marionette/lib/core/backbone.marionette',
    mustache: 'bower_components/mustache/mustache',
    text: 'bower_components/requirejs-text/text',
    backbonesyphon: 'bower_components/backbone.syphon/lib/amd/backbone.syphon',
    'backbone.wreqr': 'bower_components/backbone.wreqr/lib/backbone.wreqr',
    'backbone.babysitter': 'bower_components/backbone.babysitter/lib/backbone.babysitter',
    plupload: 'bower_components/plupload/js/plupload.full.min',
    jasmineajax: 'bower_components/jasmine-ajax/lib/mock-ajax',
    jasminejquery: 'bower_components/jasmine-jquery/lib/jasmine-jquery',
    jqueryvalidate: 'bower_components/jquery.validation/dist/jquery.validate',
    plupload: 'bower_components/plupload/js/plupload.full.min',
    backboneassociations: 'bower_components/backbone-associations/backbone-associations',
    bootstraptour: 'bower_components/bootstrap-tour/build/js/bootstrap-tour.js',
    underscorestring: 'bower_components/underscore.string/lib/underscore.string',
    extm: 'lib/extm.amd'
  },
  shim: {
    jquery: ['underscore'],
    underscorestring: ['underscore'],
    backbone: ['jquery', 'underscore'],
    marionette: {
      deps: ['backbone', 'backbone.wreqr', 'backbone.babysitter']
    },
    backbonesyphon: ['backbone'],
    backboneassociations: ['backbone'],
    jqueryvalidate: ['jquery'],
    bootstrap: ['jquery'],
    bootstraptour: ['bootstrap'],
    jasminejquery: ['jquery'],
    jasmineajax: ['jquery'],
    plupload: {
      deps: ['jquery'],
      exports: 'plupload'
    }
  }
});
