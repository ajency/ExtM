describe 'Region Controller', ->

   regionController = null

   it 'must be defined', ->
      expect( Extm.RegionController ).toBeDefined()
      expect( Extm.RegionController ).toEqual jasmine.any Function

   describe 'on construction', ->

      describe 'when no region param is passed', ->
         it 'must throw an error', ->
            expect(->
               new Extm.RegionController ).toThrow()

      describe 'when region param is passed', ->
         beforeEach ->
            setFixtures '<div id="some-region"></div>'
            spyOn( msgbus.commands, 'execute' ).and.callThrough()
            regionController = new Extm.RegionController
               region : new Marionette.Region el : '#some-region'

         afterEach ->
            regionController.destroy()

         it 'must set its own region property', ->
            expect( regionController.region instanceof Marionette.Region ).toBeTruthy()

         it 'msgbus must execute a command', ->
            expect(msgbus.commands.execute).toHaveBeenCalledWith 'register:controller', regionController.instanceId, regionController


   describe 'on destroying', ->

      beforeEach ->
         setFixtures '<div id="some-region"></div>'
         spyOn( msgbus.commands, 'execute' ).and.callThrough()
         regionController = new Extm.RegionController
                                       region : new Marionette.Region el : '#some-region'
                                       otherRef : 'some value'

         regionController.onDestroy = ->
         spyOn(regionController, 'onDestroy' ).and.callThrough()
         regionController.destroy()

      afterEach ->
         regionController = null

      it 'must delete reference to region', ->
         expect( regionController.region ).not.toEqual jasmine.any Object

      it 'must delete reference to currentView', ->
         expect( regionController.currentView ).not.toEqual jasmine.any Object

      it 'must delete options reference', ->
         expect( regionController.getOption 'otherRef' ).not.toBe 'some value'

      it 'msgbus must execute a command', ->
         expect(msgbus.commands.execute).toHaveBeenCalledWith 'unregister:controller', regionController.instanceId, regionController

      it 'must still have default destroy behavior', ->
         expect( regionController.onDestroy ).toHaveBeenCalled()

   describe 'on show', ->
      view = null
      beforeEach ->
         setFixtures '<div id="some-region"></div>'
         regionController = new Extm.RegionController
                                 region : new Marionette.Region el : '#some-region'
                                 otherRef : 'some value'
         view = new Marionette.ItemView template : 'view'
         view.onShow = ->
         spyOn view, 'onShow'
         regionController.show view

      afterEach ->
         regionController.destroy()

      it 'must have view object assign to controller view property', ->
         expect(regionController.currentView).toBe view

      it 'must show the view', ->
         expect( view.onShow ).toHaveBeenCalled()