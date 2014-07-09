define [ 'extm', 'app/js/apps/left-nav/left-nav-view' ], ( Extm, LeftNavView )->

   class LeftNavController extends Extm.RegionController

      initialize : ( options )->
         { view } = options

         @store().find 'view', view
         @store().find 'unit'
         @wait()

      onComplete : ( viewmodel, unitcollection )->
         @show new LeftNavView
                     collection : unitcollection
                     model : viewmodel


   msgbus.registerController 'leftnav', LeftNavController

   LeftNavController




