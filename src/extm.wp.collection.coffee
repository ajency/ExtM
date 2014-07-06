
# extends default backbone.collection
_.extend Backbone.Collection::,

   # capture Marionette's trigger method proxy
   triggerMethod : Marionette.triggerMethod

   # capture marionette's getOption proxy
   getOption : Marionette.proxyGetOption