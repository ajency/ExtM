define [ 'extm', 'app/js/apps/header/header-view' ], ( Extm, HeaderView )->

   class HeaderController extends Extm.RegionController

      initialize : ( options )->
         { view } = options

         @store().find 'view', view
         @store().find 'unit', {building : 54}
         @wait()

      onComplete : ( model, collection )->
         @show new HeaderView
                     collection : collection
                     model : model

   msgbus.registerController 'header', HeaderController

   HeaderController




