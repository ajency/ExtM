define [ 'extm', 'app/js/apps/header/header-view' ], ( Extm, HeaderView )->

   class HeaderController extends Extm.RegionController

      initialize : (options)->

         { @region } = options

         @region.show new HeaderView




