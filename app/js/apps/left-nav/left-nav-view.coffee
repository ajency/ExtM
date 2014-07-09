define [ 'extm', 'marionette' ], ( Extm, Marionette )->

   class CView extends Marionette.ItemView

      tagName : 'li'
      template : '{{name}}'


   class LeftNavView extends Marionette.CompositeView

      childView : CView

      childViewContainer : 'ul'

      template : '<div>view name : {{name}}
                     <img src="{{picture}}" />
                  </div>
                  <ul></ul>'