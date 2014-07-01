class Extm.RegionController extends Marionette.Controller

   # holds the region this controller is controlling.
   # Must be an object of Marionette.Region or its subclass
   region : false

   # current View this region will show.
   # one region can show only one view
   currentView : false

   # contruct the controller
   constructor : ( options = {} ) ->

      # continue with super controller constructor
      super options

      if not options.region
         throw new Error 'Region is not specified for the controller'

      @_assignRegion options.region
      @instanceId = _.uniqueId 'region-controller-'

      msgbus.commands.execute 'register:controller', @instanceId, @

   _assignRegion : ( region )->
      @region = region

   destroy : ( args... ) ->
      delete @region
      delete @currentView
      delete @options
      msgbus.commands.execute "unregister:controller", @instanceId, @
      super args

   show : ( view ) ->
      @currentView = view
      @region.show view
