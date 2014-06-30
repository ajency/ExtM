
# set all plugins for this page here
require [ 'extm' ], ( Extm )->

   window.App = new Extm.Application

   App.addRegions
      headerRegion : '#header-region'


   class V extends Marionette.ItemView
      template : 'hello world'

   class Rv extends Extm.RegionController

      initialize : (options)->

         @show new V

   App.start()

   new Rv
      region : App.headerRegion

