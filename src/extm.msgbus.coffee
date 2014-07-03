
# decouple global messaging system from application object
# will help in testing
window.msgbus = Backbone.Wreqr.radio.channel "global"

