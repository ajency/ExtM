##
## Set backbone overrites or mixins
##
define [ 'marionette' ], ( Marionette )->

   # Extends the Marionette.Application to add some additional functions
   _.extend Marionette.Application::,

      onStart : ->
         @startHistory()
         @navigate

      navigate : ( route, options = {} ) ->
         Backbone.history.navigate route, options

      getCurrentRoute : ->
         frag = Backbone.history.fragment
         if _.isEmpty( frag ) then null else frag

      startHistory : ->
         if Backbone.history
            Backbone.history.start()

   # register a controller instance
      register : ( instance, id ) ->
         @_registry ?= {}
         @_registry[id] = instance


      unregister : ( instance, id ) ->
         delete @_registry[id]

      resetRegistry : ->
         oldCount = @getRegistrySize()
         for key, controller of @_registry
            controller.region.close()
         msg = "There were #{oldCount} controllers in the registry, there are now #{@getRegistrySize()}"
         if @getRegistrySize() > 0 then console.warn( msg, @_registry ) else console.log( msg )

      getRegistrySize : ->
         _.size @_registry

   # register a controller instance
      registerElement : ( instance, id ) ->
         @_elementRegistry ?= {}
         @_elementRegistry[id] = instance

   # unregister a controller instance
      unregisterElement : ( instance, id ) ->
         delete @_elementRegistry[id]

      resetElementRegistry : ->
         oldCount = @getElementRegistrySize()
         for key, controller of @_elementRegistry
            controller.layout.close()
         msg = "There were #{oldCount} controllers in the registry, there are now #{@getElementRegistrySize()}"
         if @getElementRegistrySize() > 0 then console.warn( msg, @_elementRegistry ) else console.log( msg )

      getElementRegistrySize : ->
         _.size @_elementRegistry