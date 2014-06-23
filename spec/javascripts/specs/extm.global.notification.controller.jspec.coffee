define [ 'src/extm.global.notification.controller' ], ( NotificationController )->

   describe 'Global notification controller', ->

      notificationController = null

      describe 'on initialization', ->
         beforeEach ->
            spyOn(NotificationController::,'initialize' ).and.callThrough()
            notificationController = new NotificationController()

         afterEach ->
            notificationController = {}