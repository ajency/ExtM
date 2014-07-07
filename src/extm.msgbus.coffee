# decouple global messaging system from application object
# will help in testing
window.msgbus = Backbone.Wreqr.radio.channel "global"

msgbus.request = ->
   msgbus.reqres.request.apply msgbus.reqres, arguments

msgbus.execute = ->
   msgbus.commands.request.apply msgbus.commands, arguments

msgbus.registerController = ( name, controller )->
   _Controllers[name] = controller

msgbus.showApp = ( appName )->
   appLauncher = new AppLauncher appName
   appLauncher
