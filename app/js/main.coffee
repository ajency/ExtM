define 'plugin-loader', [ '' ], ->

define 'apps-loader', [ '' ], ->

define 'extm', [ 'src/extm.namespace' ], ( Extm )->
   Extm

define [ 'plugin-loader', 'apps-loader', 'extm' ], ( plugins, apps, Extm )->

   #
   App = new Extm.Application

   App.addRegions
      headerRegion : '#header-region'
      leftNavRegion : '#left-nav-region'

   App.onStart = ->


   App.setDefaultRoute '#/home'

   App.start()