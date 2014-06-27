define ['../../src/extm.application'], (Application)->


   Application.onStart = ->

   Application.setDefaultRoute '//home'

   Application.start
               regions :
                  headerRegion : '#header-region'
                  leftNavRegion : '#left-nav-region'