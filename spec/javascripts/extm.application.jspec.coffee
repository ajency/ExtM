describe 'ExtmAplication', ->
   it 'must be defined', ->
      expect( Extm.Application ).toBeDefined()
      expect( Extm.Application ).toEqual jasmine.any Function

   it 'must have default route to be ""', ->
      App = new Extm.Application
      expect( App.defaultRoute ).toBe ''

   describe 'when have a default route equal to "some-route"', ->
      it 'must have default route to be "some-route"', ->
         App = new Extm.Application
         App.setDefaultRoute 'some-route'
         expect( App.defaultRoute ).toBe 'some-route'

   describe 'when app starts without adding any regions', ->
      afterEach ->
         Backbone.history.stop()

      app = new Extm.Application
      it 'must throw an error', ->
         expect(->
            app.start() ).toThrow()

   describe 'when app starts with region hash', ->
      App = ''
      beforeEach ->
         App = new Extm.Application
         App.onStart = ->
         spyOn( App, 'onStart' )
         App.addRegions (regionName : '#region-element')
         App.start()

      afterEach ->
         Backbone.history.stop()
         App = {}

      it 'must set the app region', ->
         expect( App.getRegion( 'regionName' ) instanceof Marionette.Region ).toBeTruthy()

      it 'must still have default functionality of Marionette.Application', ->
         expect( App.onStart ).toHaveBeenCalled()

      it 'must start the backbone history', ->
         expect( App.histroyStarted ).toBeTruthy()

   describe 'when current route is empty', ->
      App = ''
      beforeEach ->
         window.location.hash = ''
         App = new Extm.Application
         App.addRegions (regionName : '#region-element')

      afterEach ->
         Backbone.history.stop()
         App = {}

      it 'must navigate to "" route', ->
         App.start()
         expect( App.getCurrentRoute() ).toBe ''

      it 'must navigate to default route', ->
         App.setDefaultRoute 'new-route'
         App.start()
         expect( App.getCurrentRoute() ).toBe 'new-route'

   describe 'when current route not empty', ->
      app = {}
      beforeEach ->
         window.location.hash = '#/some-hash'
         app = new Extm.Application
         app.addRegions (regionName : '#region-element')
         app.start()

      afterEach ->
         Backbone.history.stop()
         window.location.hash = ''
         app = {}

      it 'must navigate to default route', ->
         expect( app.getCurrentRoute() ).toBe 'some-hash'

   describe 'Static apps', ->
      App = null
      apps = [
         [ 'app1', new Marionette.Region 'el' : '#dsds' ]
         [ 'app2', new Marionette.Region 'el' : '#dsds' ]
      ]
      beforeEach ->
         App = new Extm.Application
         App.onStart = ->
         spyOn( App, 'onStart' )
         App.addRegions regions : { regionName : '#region-element' }

      afterEach ->
         App = null

      describe 'when adding static apps', ->

         it 'must assign static apps as its property( _staticApps )', ->
            App.addStaticApps apps
            expect(App._staticApps).toEqual jasmine.any Array
            expect(App._staticApps.length).toBe 2

      describe 'when starting static apps', ->
         describe 'when app starts', ->
            spyOn( msgbus, 'showApp' ).and.callThrough()

            beforeEach ->
               #App.addStaticApps apps
               App.start()

            it 'must call the app launcher', ->



