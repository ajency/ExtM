describe 'Extm abstract form view', ->

   it 'must be defined',->
      expect( Extm.FormView ).toBeDefined()
      expect( Extm.FormView ).toEqual jasmine.any Function

   it 'must extend from marionette.itemview', ->
      expect( Extm.FormView::serializeData ).toEqual jasmine.any Function
