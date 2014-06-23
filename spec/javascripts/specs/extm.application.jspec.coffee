define [ 'marionette', 'src/extm.application' ], ( Marionette, ExtmApplication )->
   describe 'Extended marionette application', ->
      App = {}
      beforeEach ->
         window.location.hash = ''
         App = new ExtmApplication

      afterEach ->
         Backbone.history.stop()
         window.location.hash = ''
         App = null

      describe 'Application start', ->

         describe 'when an application is started without regions hash', ->
            it 'must throw an error', ->
               expect( -> App.start() ).toThrow()


         describe 'when an application is started with regions hash', ->
            beforeEach ->
               App.start
                  regions :
                     someRegion : '#some-region'

            it 'must have region available', ->
               expect( App.getRegion( 'someRegion' ) instanceof Marionette.Region ).toBeTruthy()

      describe 'when getting the current route', ->
         beforeEach ->
            App.start regions : '#some-region'
            App.navigate 'some-hash'

         it 'must return "some-hash" as the current route',->
            expect(App.getCurrentRoute() ).toBe 'some-hash'

      describe 'when getting the initial route', ->
         beforeEach ->
            App.start regions : '#some-region'

         it 'must return "some-hash" as the current route',->
            expect(App.getCurrentRoute() ).toBe ''

      describe 'Application navigate', ->

         describe 'when application navigates with trigger', ->

            beforeEach ->
               App.start regions : '#some-region'

            it 'must change hash ', ->
               App.navigate 'somehash'
               expect(App.getCurrentRoute()).toBe 'somehash'