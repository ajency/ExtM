describe 'Marionette.Renderer', ->

   describe 'when given a template', ->

      it 'must return the template', ->
         view = Marionette.Renderer.render '<div>Template</div>'
         expect(view).toBe '<div>Template</div>'

   describe 'when given a template and data', ->

      it 'must return the template', ->
         data = data : 'foo'
         view = Marionette.Renderer.render '<div>{{data}}</div>', data
         expect(view).toBe '<div>foo</div>'

   describe 'when view runs render method', ->

      View = Marionette.ItemView.extend
                              template : '{{data}}'
      view = new View
                  model : new Backbone.Model
                                          data : 'foo'

      it 'must return proper template data', ->
         expect(view.render().$el.text()).toBe 'foo'