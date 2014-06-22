##
## Set backbone overrites or mixins
##
define ['src/extm.namespace', 'marionette', 'backbone', 'underscore' ], (Extm, Marionette, Backbone, _ )->

   # Extends the Marionette.Application to add some additional functions
   class Extm.Application extends Marionette.Application

      start : ( options = {} ) ->
         # let the default behavior continue
         super options

         if not options.regions
            throw new Error

         { regions, @rootRoute } = options

         @rootRoute = '' if  _.isUndefined @rootRoute

         @_setUpAppRegions regions
         @startHistory()
         @navigate( @rootRoute, trigger : true ) unless @getCurrentRoute()

      # calls the core backbone's navigate function
      navigate : ( route, options = {} ) ->
         Backbone.history.navigate route, options

      # returns the current route
      getCurrentRoute : ->
         frag = Backbone.history.fragment
         if _.isEmpty( frag ) then '' else frag

      # Start the history for the application
      startHistory : ->
         if Backbone.history
            Backbone.history.start()

      # setup the main application regions
      # @params : regions hash (eg: regions : { regionName : '#regions-element' })
      _setUpAppRegions : ( regions )->
         # TODO: validate regions hash
         @addRegions regions
