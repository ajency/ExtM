define [ 'marionette', 'backbone', 'jquery' ], ( Marionette, Backbone, $ )->

   msgbus = Backbone.Wreqr.radio.channel 'global'

   msgbus.execute = ->
      msgbus.commands.execute.apply msgbus.commands, arguments

   msgbus.request = ->
      msgbus.commands.execute.apply msgbus.reqres, arguments

   msgbus.event = msgbus.vent

   # set handlers
   msgbus.commands.setHandler 'when:fetched', ( deffereds, callback ) ->
      $.when( deffereds... ).done ->
         callback()

   msgbus