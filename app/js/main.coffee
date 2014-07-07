# set all plugins for this page here

define 'apps-loader', [ 'app/js/apps/header/header-controller' ], ->

require [ 'extm', 'apps-loader' ], ( Extm )->

   window.App = new Extm.Application

   App.addRegions
      headerRegion : '#header-region'

   App.addStaticApps [
      [ 'header', App.headerRegion ]
   ]

   App.start()