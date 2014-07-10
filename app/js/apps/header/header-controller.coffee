define [ 'extm', 'app/js/apps/header/header-view' ], ( Extm, HeaderView )->

   class HeaderController extends Extm.RegionController

      initialize : ( options )->
         { view } = options

         @store().find 'view', [11, 12, 13]
         @wait()

      onComplete : ( viewCollection )->
         console.log viewCollection
         @show new HeaderView
                     collection : viewCollection

   msgbus.registerController 'header', HeaderController

   HeaderController




