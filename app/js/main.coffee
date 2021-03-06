# set all plugins for this page here

define 'apps-loader', [
      'app/js/apps/header/header-controller'
      'app/js/apps/left-nav/left-nav-controller'
   ], ( Controllers... )->

require [ 'extm', 'apps-loader' ], ( Extm )->

   window.App = new Extm.Application

   App.addRegions
      headerRegion : '#header-region'
      leftNavRegion : '#left-nav-region'

   App.addStaticApps [
      [ 'header', App.headerRegion, view : 11 ]
      [ 'leftnav', App.leftNavRegion, view : 12 ]
   ]

   flats = [
      (
         id : 23
         views : 5
         name : 'Awesome blue flat'
         building : 54
      )
      (
         id : 24
         views : 4
         name : 'Awesome red flat'
         building : 54
      )
      (
         id : 25
         views : 2
         name : 'Awesome pink flat'
         building : 56
      )
      (
         id : 26
         views : 9
         name : 'Awesome yellow flat'
         building : 57
      )
   ]

   App.store.push 'unit', flats

   views  = [
      (
         id : 12
         name : 'River View'
         picture : 'http://placehold.it/300x200'
      )
      (
         id : 11
         name : 'Garden View'
         picture : 'http://placehold.it/500x200'
      )
   ]

   App.store.push 'view', views

   App.start()