define [ 'marionette', 'src/extm.application' ], ( Marionette )->

   describe 'Extended marionette application', ->

      describe 'when application starts', ->
         App = null

         beforeEach ->
            spyOn(Backbone.history, 'start' ).and.callThrough()
            App = new Marionette.Application
            App.start()

         afterEach ->
            App = null

         it "must start backbone history",->
            expect(Backbone.history.start).toHaveBeenCalled()

