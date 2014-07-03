describe 'Extm message bus', ->

   it 'must be defined', ->
      expect( window.msgbus ).toBeDefined()
      expect( window.msgbus ).toEqual jasmine.any Object
