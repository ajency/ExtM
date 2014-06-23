define [ 'src/extm.msgbus' ], ( msgbus )->

   describe 'global msgbus', ->
      it 'must be defined and must be an object', ->
         expect( msgbus ).toBeDefined()
         expect( msgbus ).toEqual jasmine.any Object
         expect( msgbus.execute ).toEqual jasmine.any Function
         expect( msgbus.request ).toEqual jasmine.any Function
         expect( msgbus.event.trigger ).toEqual jasmine.any Function

      it 'must have a handler', ->
         expect( msgbus.commands.hasHandler 'when:fetched' ).toBeTruthy()

      describe 'msgbus fetch handler', ->
         commandHandler = null
         beforeEach ->
            commandHandler = jasmine.createSpy 'command:handler:callback'
            msgbus.execute 'when:fetched', [], commandHandler

         it 'must execute the passed callback function', ->
            expect( commandHandler ).toHaveBeenCalled()
            expect( commandHandler.calls.count() ).toBe 1