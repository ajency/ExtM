##
## Set backbone overrites or mixins
##
define [
   'src/extm.application'
   'src/extm.marionette.renderer'
], ( ExtmApplication )->

   Extm = {}

   # attach all Objects
   Extm.Application = ExtmApplication

   Extm


