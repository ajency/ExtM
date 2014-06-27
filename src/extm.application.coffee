##
## Set backbone overrites or mixins
##
define [ 'marionette', 'backbone', 'underscore' ], ( Marionette, Backbone, _ )->

   # Extends the Marionette.Application to add some additional functionality
   # extended start function which does something more then default start
   class ExtmApplication extends Marionette.Application

      # extra property of application to track if history is started or not
      histroyStarted : false

      # default route of the application.
      # this is used by initial navigate function to run first route
      # @see: ExtmApplication.setDefaultRoute(route)
      defaultRoute : ''

      # @override: start method of marionette add some extra functionality
      # @params : Object
      #     { regions : { regionName : '#element' }}
      # Throws if regions hash is missing
      start : ( options = {} ) ->

         # cannot start the app without any application regions
         # check for regions hash in options and throws error if not found
         if _.size( @getRegions() ) is 0
            throw new Error 'application regions not specified'

         # continue to have the default start behavior
         # calling start of Marionette.Application
         super options

         # finally start the history.
         @startHistory()

      # setup the application regions
      _setUpRegions : ( regions )->
         # TODO: validate regions hash
         @addRegions regions

      # starts backbone.history
      startHistory : ->
         if not @histroyStarted
            Backbone.history.start()
            @navigate( @defaultRoute, trigger : true ) if @getCurrentRoute() is ''
            @histroyStarted = true

      # @uses Backbone.navigate to change current route and trigger if passed
      # @params:
      #   options = { trigger : true} || any options possible in backbone.history.navigate
      navigate : ( route, options )->
         Backbone.history.navigate route, options

      setDefaultRoute : ( route = '' )->
         @defaultRoute = route

      # uses backbone to get the current route
      getCurrentRoute : ->
         frag = Backbone.history.fragment
         if _.isEmpty( frag ) then '' else frag