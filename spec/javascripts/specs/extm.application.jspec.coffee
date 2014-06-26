define [ 'marionette', 'src/extm.application' ], ( Marionette, ExtmApplication )->

   describe 'Extended marionette application', ->
      it 'must be defined', ->
         expect( ExtmApplication ).toBeDefined()
         expect( ExtmApplication ).toEqual jasmine.any Function

   describe 'can have a default route', ->

      it 'must have default route to be ""', ->
         App = new ExtmApplication
         expect( App.defaultRoute ).toBe ''

         App.setDefaultRoute 'some-hash'
         expect( App.defaultRoute ).toBe 'some-hash'

   describe 'when app starts', ->
      afterEach ->
         Backbone.history.stop()

      describe 'when app starts without region hash', ->
         App = ''
         beforeEach ->
            spyOn( ExtmApplication::, 'start' ).and.callThrough()
            App = new ExtmApplication

         afterEach ->
            App = {}

         it 'must throw an error', ->
            expect(-> App.start() ).toThrow()

      describe 'when app starts with region hash', ->
         App = ''
         onStart = null
         beforeEach ->
            App = new ExtmApplication
            App.onStart = ->
            onStart = spyOn( App, 'onStart' )
            App.start regions :
               regionName : '#region'

         afterEach ->
            Backbone.history.stop()
            App = {}

         it 'must set the app region', ->
            expect( App.getRegion( 'regionName' ) instanceof Marionette.Region ).toBeTruthy()

         it 'must run onStart function', ->
            expect( onStart ).toHaveBeenCalled()

         it 'must start the backbone history', ->
            expect( App.histroyStarted ).toBeTruthy()

      describe 'when current route is empty', ->
         App = ''
         beforeEach ->
            window.location.hash = ''
            App = new ExtmApplication

         afterEach ->
            window.location.hash = ''
            App = {}

         it 'must navigate to "" route', ->
            App.start regions :
                           name : '#hash'
            expect( App.getCurrentRoute() ).toBe ''

         it 'must navigate to default route', ->
            App.setDefaultRoute 'new-route'
            App.start regions :
                           name : '#hash'
            expect( App.getCurrentRoute() ).toBe 'new-route'

      describe 'when current route not empty', ->
         App = {}
         beforeEach ->
            window.location.hash = '#/some-hash'
            App = new ExtmApplication
            App.start regions :
                        name : '#hash'

         afterEach ->
            Backbone.history.stop()
            window.location.hash = ''
            App = {}

         it 'must navigate to default route', ->
            expect( App.getCurrentRoute() ).toBe 'some-hash'