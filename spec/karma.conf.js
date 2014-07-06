// Karma configuration
// Generated on Sun Jun 29 2014 13:21:11 GMT+0530 (IST)

module.exports = function ( config ) {
    config.set( {

        // base path that will be used to resolve all patterns (eg. files, exclude)
        basePath : '../',

        // frameworks to use
        // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
        frameworks : ['jasmine'],

        // list of files / patterns to load in the browser
        files : [
            'bower_components/underscore/underscore.js',
            'bower_components/jquery/dist/jquery.js',
            'bower_components/backbone/backbone.js',
            'bower_components/marionette/lib/backbone.marionette.js',
            'bower_components/mustache/mustache.js',
            'bower_components/jquery.validation/dist/jquery.validate.js',
            'bower_components/backbone-associations/backbone-associations.js',
            'bower_components/jasmine-ajax/lib/mock-ajax.js',
            'bower_components/jasmine-jquery/lib/jasmine-jquery.js',
            'tmp/extm.core.js',
            'spec/javascripts/helpers/*.js',
            'spec/javascripts/**/*.jspec.js'
        ],

        // list of files to exclude
        exclude : [

        ],

        // preprocess matching files before serving them to the browser
        // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
        preprocessors : {

        },

        // test results reporter to use
        // possible values: 'dots', 'progress'
        // available reporters: https://npmjs.org/browse/keyword/karma-reporter
        reporters : ['progress'],

        // web server port
        port : 9876,

        // enable / disable colors in the output (reporters and logs)
        colors : true,

        // level of logging
        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        logLevel : config.LOG_INFO,

        // enable / disable watching file and executing tests whenever any file changes
        autoWatch : true,

        // start these browsers
        // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
        browsers : ['PhantomJS'],

        // Continuous Integration mode
        // if true, Karma captures browsers, runs the tests and exits
        singleRun : false
    } );
};
